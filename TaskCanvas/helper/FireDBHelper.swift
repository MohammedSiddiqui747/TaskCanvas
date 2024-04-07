//
//  FireDBHelper.swift
//  CollegeDelivery
//
//  Created by Mohammed Siddiqui.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var itemList = [Item]()
    @Published var reqItemList = [Item]()
    
    private let db : Firestore
    
    //singleton design pattern
    //singleton object
    
    private static var shared : FireDBHelper?
    
    private let COLLECTION_NAME = "Items"
    private let COLLECTION_REQ = "ReqItems"
    private let ATTRIBUTE_INAME = "itemName"
    private let ATTRIBUTE_IDESC = "itemDesc"
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
    
    
    func insertItem(item : Item){
        do{
            
            try self.db.collection(COLLECTION_NAME).addDocument(from: item)
            
        }catch let err as NSError{
            print(#function, "Unable to insert : \(err)")
        }
    }
    
    func insertReqItem(item : Item){
        do{
            
            try self.db.collection(COLLECTION_REQ).addDocument(from: item)
            
        }catch let err as NSError{
            print(#function, "Unable to insert : \(err)")
        }
    }
    
    func deleteItem(docIDtoDelete: String) {
        self.db.collection(COLLECTION_NAME).document(docIDtoDelete).delete { error in
            if let err = error {
                print(#function, "Unable to delete : \(err)")
            } else {
                print(#function, "Document deleted successfully")
                DispatchQueue.main.async {
                    // Ensure the deletion is also reflected in itemList
                    self.itemList.removeAll { $0.id == docIDtoDelete }
                }
            }
        }
    }
    
    func deleteReqItem(docIDtoDelete: String) {
        // First, remove the item from the local list for immediate UI update
        DispatchQueue.main.async {
            self.reqItemList.removeAll { $0.id == docIDtoDelete }
        }

        // Then, perform the Firestore deletion
        self.db.collection(COLLECTION_REQ).document(docIDtoDelete).delete { error in
            if let err = error {
                print(#function, "Unable to delete : \(err)")
                // Optionally, handle re-adding the item or notifying the user upon error
            } else {
                print(#function, "Document deleted successfully")
            }
        }
    }
    
    func retrieveAllItems(){
        
        do{
            
            self.db
                .collection(COLLECTION_NAME)
                .order(by: ATTRIBUTE_INAME, descending: true)
                .addSnapshotListener( { (snapshot, error) in
                    
                    guard let result = snapshot else{
                        print(#function, "Unable to retrieve snapshot : \(String(describing: error))")
                        return
                    }
                    
                    print(#function, "Result : \(result)")
                    
                    result.documentChanges.forEach{ (docChange) in
                        
                        do{
                            //obtain the document as Student class object
                            let item = try docChange.document.data(as: Item.self)
                            
                            print(#function, "item from db : id : \(String(describing: item.id)) name : \(item.itemName)")
                            
                            //check if the changed document is already in the list
                            let matchedIndex = self.itemList.firstIndex(where: { ($0.id?.elementsEqual(item.id!))!})
                            
                            if docChange.type == .added{
                                
                                if (matchedIndex != nil){
                                    //the document object is already in the list
                                    //do nothing to avoid duplicates
                                }else{
                                    self.itemList.append(item)
                                }
                                
                                print(#function, "New document added : \(item)")
                            }
                            
                            if docChange.type == .modified{
                                print(#function, "Document updated : \(item)")
                                
//                                if (matchedIndex != nil){
//                                    //the document object is already in the list
//                                    //replace existing document
//                                    self.studentList[matchedIndex!] = stud
//                                }
                            }
                            
                            if docChange.type == .removed{
                                print(#function, "Document deleted : \(item)")
                                
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
            
        }
        /*
        catch let err as NSError{
            print(#function, "Unable to retrieve \(err)" )
        }
         */
        
    }
    
    func retrieveAllReqItems(){
        
        do{
            
            self.db
                .collection(COLLECTION_REQ)
                .order(by: ATTRIBUTE_INAME, descending: true)
                .addSnapshotListener( { (snapshot, error) in
                    
                    guard let result = snapshot else{
                        print(#function, "Unable to retrieve snapshot : \(String(describing: error))")
                        return
                    }
                    
                    print(#function, "Result : \(result)")
                    
                    result.documentChanges.forEach{ (docChange) in
                        
                        do{
                            //obtain the document as Student class object
                            let item = try docChange.document.data(as: Item.self)
                            
                            print(#function, "item from db : id : \(String(describing: item.id)) name : \(item.itemName)")
                            
                            //check if the changed document is already in the list
                            let matchedIndex = self.reqItemList.firstIndex(where: { ($0.id?.elementsEqual(item.id!))!})
                            
                            if docChange.type == .added{
                                
                                if (matchedIndex != nil){
                                    //the document object is already in the list
                                    //do nothing to avoid duplicates
                                }else{
                                    self.reqItemList.append(item)
                                }
                                
                                print(#function, "New document added : \(item)")
                            }
                            
                            if docChange.type == .modified{
                                print(#function, "Document updated : \(item)")
                                
//                                if (matchedIndex != nil){
//                                    //the document object is already in the list
//                                    //replace existing document
//                                    self.studentList[matchedIndex!] = stud
//                                }
                            }
                            
                            if docChange.type == .removed{
                                print(#function, "Document deleted : \(item)")
                                
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
            
        }
        /*
         catch let err as NSError{
            print(#function, "Unable to retrieve \(err)" )
        }
         */
        
    }
    
    func retrieveItemByName(iname : String){
        do{
            
            self.db
                .collection(COLLECTION_NAME)
                .whereField("itemName", isGreaterThanOrEqualTo: iname)
                .addSnapshotListener( { (snapshot, error) in
                    
                    guard let result = snapshot else {
                        print(#function, "Unable to search database for the item due to error  : \(String(describing: error))")
                        return
                    }
                    
                    print(#function, "Result of search by name : \(result)")
                    
                    result.documentChanges.forEach{ (docChange) in
                        //try to convert the firestore document to Student object and update the studentList
                        do{
                            let item = try docChange.document.data(as: Item.self)
                            
                            if docChange.type == .added{
                                self.itemList.append(item)
                            }
                        }catch let err as NSError{
                            print(#function, "Unable to obtain Item object \(err)" )
                        }
                    }
                })
            
        }
        /*
         catch let err as NSError{
            print(#function, "Unable to retrieve \(err)" )
        }
         */
    }
    
    func updateItem( updatedItemIndex : Int ){
        
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
            .collection(COLLECTION_NAME)
            .document(self.itemList[updatedItemIndex].id!)
            .updateData([ATTRIBUTE_INAME : self.itemList[updatedItemIndex].itemName,
                         ATTRIBUTE_IDESC : self.itemList[updatedItemIndex].itemDesc
                        ]){ error in
                
                if let err = error{
                    print(#function, "Unable to update document : \(err)")
                }else{
                    print(#function, "Document updated successfully")
                }
                
            }
    }
    func updateWidgetData() {
           let userDefaults = UserDefaults(suiteName: "group.com.ms.CollegeDelivery")
           do {
               let data = try JSONEncoder().encode(itemList)
               userDefaults?.set(data, forKey: "ItemList")
           } catch {
               print("Error encoding itemList: \(error)")
           }
       }
    
    func retrieveAllItemsFromLocation(locationOfItems: String){
        do{
            self.db
                .collection(COLLECTION_NAME)
                .order(by: ATTRIBUTE_INAME, descending: true)
                .whereField("itemLoc", isEqualTo: locationOfItems)
                .addSnapshotListener( { (snapshot, error) in
                    guard let result = snapshot else{
                        print(#function, "Unable to retrieve snapshot : \(String(describing: error))")
                        return
                    }
                    print(#function, "Result : \(result)")
                    result.documentChanges.forEach{ (docChange) in
                        do{
                            let item = try docChange.document.data(as: Item.self)
                            print(#function, "item from db : id : \(String(describing: item.id)) name : \(item.itemName)")
                            let matchedIndex = self.itemList.firstIndex(where: { ($0.id?.elementsEqual(item.id!))!})
                            if docChange.type == .added{
                                if (matchedIndex != nil){
                                } else {
                                    self.itemList.append(item)
                                }
                                print(#function, "New document added : \(item)")
                            }
                            if docChange.type == .modified{
                                print(#function, "Document updated : \(item)")
                            }
                            if docChange.type == .removed{
                                print(#function, "Document deleted : \(item)")
                            }
                        }catch let err as NSError{
                            print(#function, "Unable to access document change : \(err)")
                        }
                    }
                })
        }
        /*
         catch let err as NSError {
            print(#function, "Unable to retrieve \(err)" )
        }
         */
    }
    
    
}
