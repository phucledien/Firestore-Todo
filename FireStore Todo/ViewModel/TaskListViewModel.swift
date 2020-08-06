//
//  TaskListViewModel.swift
//  FireStore Todo
//
//  Created by phucld on 8/5/20.
//  Copyright © 2020 phucledien. All rights reserved.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private let taskRepository = TaskRepository()
    private var cancellables = Set<AnyCancellable>()

    init() {
        taskRepository.$tasks
            .map { tasks in
                tasks.map { TaskCellViewModel(task: $0) }
            }
            .assign(to: \.taskCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addTask(task: Task) {
        taskRepository.addTask(task: task)
    }
    
    func updateTask(task: Task) {
        taskRepository.updateTask(task: task)
    }
}
