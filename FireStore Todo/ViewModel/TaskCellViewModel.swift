//
//  TaskCellViewModel.swift
//  FireStore Todo
//
//  Created by phucld on 8/5/20.
//  Copyright © 2020 phucledien. All rights reserved.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var task: Task
    @Published var completionStateIconName = ""
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap { task in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
