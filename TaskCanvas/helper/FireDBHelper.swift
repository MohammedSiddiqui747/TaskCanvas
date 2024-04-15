//
//  FireDBHelper.swift
//  TaskCanvas
//
//  Created by Mohammed Siddiqui on 2024-04-14.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var taskList = [Task]()
    
    private let db : Firestore
    
    //singleton design pattern
    //singleton object
    
    private static var shared : FireDBHelper?
    
    private let COLLECTION_TASK = "Task"
    private let ATTRIBUTE_TNAME = "taskName"
    private let ATTRIBUTE_TDESC = "taskDesc"
    private let ATTRIBUTE_TTYPE = "taskType"
    private let ATTRIBUTE_TDATE = "taskDate"
    private let ATTRIBUTE_UEMAIL = "userEmail"

    
    private init(database : Firestore){
        self.db = database
    }
    
    static func getInstance() -> FireDBHelper{
        
        if (self.shared == nil){
            shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return self.shared!
    }
    
    
    func insertTask(task : Task){
        do{
            
            try self.db.collection(COLLECTION_TASK).addDocument(from: task)
            
        }catch let err as NSError{
            print(#function, "Unable to insert : \(err)")
        }
    }
    
    
    func deleteTask(docIDtoDelete: String) {
        self.db.collection(COLLECTION_TASK).document(docIDtoDelete).delete { error in
            if let err = error {
                print(#function, "Unable to delete : \(err)")
            } else {
                print(#function, "Document deleted successfully")
                DispatchQueue.main.async {
                    // Ensure the deletion is also reflected in itemList
                    self.taskList.removeAll { $0.id == docIDtoDelete }
                }
            }
        }
    }
    
    
    func retrieveAllTasks(){
        
        do{
            
            self.db
                .collection(COLLECTION_TASK)
                .order(by: ATTRIBUTE_TNAME, descending: true)
                .addSnapshotListener( { (snapshot, error) in
                    
                    guard let result = snapshot else{
                        print(#function, "Unable to retrieve snapshot : \(error)")
                        return
                    }
                    
                    print(#function, "Result : \(result)")
                    
                    result.documentChanges.forEach{ (docChange) in
                        
                        do{
                            //obtain the document as Student class object
                            let task = try docChange.document.data(as: Task.self)
                            
                            print(#function, "task from db : id : \(task.id) name : \(task.taskName)")
                            
                            //check if the changed document is already in the list
                            let matchedIndex = self.taskList.firstIndex(where: { ($0.id?.elementsEqual(task.id!))!})
                            
                            if docChange.type == .added{
                                
                                if (matchedIndex != nil){
                                    //the document object is already in the list
                                    //do nothing to avoid duplicates
                                }else{
                                    self.taskList.append(task)
                                }
                                
                                print(#function, "New document added : \(task)")
                            }
                            
                            if docChange.type == .modified{
                                print(#function, "Document updated : \(task)")
                                
//                                if (matchedIndex != nil){
//                                    //the document object is already in the list
//                                    //replace existing document
//                                    self.studentList[matchedIndex!] = stud
//                                }
                            }
                            
                            if docChange.type == .removed{
                                print(#function, "Document deleted : \(task)")
                                
//                                if (matchedIndex != nil){
//                                    //the document object is still in the list
//                                    //delete existing document
//                                    self.studentList.remove(at: matchedIndex!)
//                                }
                            }
                            
                        }catch let err as NSError{
                            print(#function, "Unable to access document change : \(err)")
                        }
                        
                    }
                })
            
        } catch let err as NSError{
            print(#function, "Unable to retrieve \(err)" )
        }
        
    }
    
    
    func retrieveTaskByName(tname : String){
        do{
            
            self.db
                .collection(COLLECTION_TASK)
                .whereField("taskName", isGreaterThanOrEqualTo: tname)
                .addSnapshotListener( { (snapshot, error) in
                    
                    guard let result = snapshot else {
                        print(#function, "Unable to search database for the item due to error  : \(error)")
                        return
                    }
                    
                    print(#function, "Result of search by name : \(result)")
                    
                    result.documentChanges.forEach{ (docChange) in
                        //try to convert the firestore document to Student object and update the studentList
                        do{
                            let task = try docChange.document.data(as: Task.self)
                            
                            if docChange.type == .added{
                                self.taskList.append(task)
                            }
                        }catch let err as NSError{
                            print(#function, "Unable to obtain Item object \(err)" )
                        }
                    }
                })
            
        }catch let err as NSError{
            print(#function, "Unable to retrieve \(err)" )
        }
    }
    
    func updateTask( updatedTaskIndex : Int ){
        
//        //setData more apprpropriate if entire document needs to be updated
//        do{
//            try self.db
//                .collection(COLLECTION_NAME)
//                .document(self.studentList[updatedStudentIndex].id!)
//                .setData(from: self.studentList[updatedStudentIndex])
//        }catch let err as NSError{
//            print(#function, "Unable to update \(err)" )
//        }
        
        //updateData more apprpropriate if some fields of document needs to be updated
        self.db
            .collection(COLLECTION_TASK)
            .document(self.taskList[updatedTaskIndex].id!)
            .updateData([ATTRIBUTE_TNAME : self.taskList[updatedTaskIndex].taskName,
                         ATTRIBUTE_TDESC : self.taskList[updatedTaskIndex].taskDesc
                        ]){ error in
                
                if let err = error{
                    print(#function, "Unable to update document : \(err)")
                }else{
                    print(#function, "Document updated successfully")
                }
                
            }
    }
    
    
}
