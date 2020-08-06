//
//  Task.swift
//  FireStore Todo
//
//  Created by phucld on 8/5/20.
//  Copyright © 2020 phucledien. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG
let testDataTasks = [
    Task(title: "Implement the UI", completed: true),
    Task(title: "Connect to Firebase", completed: false),
    Task(title: "????", completed: false),
    Task(title: "Profit!", completed: false),
]
#endif
