//
//  TaskRepository.swift
//  FireStore Todo
//
//  Created by phucld on 8/6/20.
//  Copyright © 2020 phucledien. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        db.collection("tasks")
            .whereField("userId", isEqualTo: uid)
            .order(by: "createdTime")
            .addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Task.self)
                }
            }
        }
    }
    
    func addTask(task: Task) {
        do {
            var addedTask = task
            addedTask.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("tasks").addDocument(from: addedTask)
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(task: Task) {
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID).setData(from: task)
            } catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
}
