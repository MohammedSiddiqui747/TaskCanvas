//
//  Task.swift
//  TaskCanvas
//
//  Created by Mohammed Siddiqui on 2024-04-14.
//

import Foundation
import FirebaseFirestoreSwift

//model

struct Task : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    
    var taskName : String = ""
    var taskDesc : String = ""
    var taskType : String = ""
    var calendarType : String = ""
    var taskDate : String = ""
    var userEmail : String = ""

    
    init(){
        self.taskName = "NA"
        self.taskDesc = "NA"
        self.taskType = "NA"
        self.calendarType = "NA"
        self.taskDate = "NA"
        self.userEmail = "NA"

        
    }
    
    init(taskname: String, taskdesc: String, tasktype: String, caltype: String, taskdate: String, useremail: String) {
        

        self.taskName = taskname
        self.taskDesc = taskdesc
        self.taskType = tasktype
        self.calendarType = caltype
        self.taskDate = taskdate
        self.userEmail = useremail
    }
    
    //JSON object to Swift Object
    
//    //failable initializer
    init?(dictionary: [String: Any]){
        
        guard let taskName = dictionary["taskName"] as? String else{
            return nil
        }
        
        guard let taskDesc = dictionary["taskDesc"] as? String else{
            return nil
        }
        
        guard let taskType = dictionary["taskType"] as? String else{
            return nil
        }
        
        guard let calendarType = dictionary["calendarType"] as? String else{
            return nil
        }
        
        guard let taskDate = dictionary["taskDate"] as? String else{
            return nil
        }
        
        guard let userEmail = dictionary["userEmail"] as? String else{
            return nil
        }
        
        self.init(taskname: taskName, taskdesc: taskDesc, tasktype: taskType, caltype: calendarType, taskdate: taskDate, useremail: userEmail)
        
    }
}
