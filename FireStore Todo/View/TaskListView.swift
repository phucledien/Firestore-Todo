//
//  ContentView.swift
//  FireStore Todo
//
//  Created by phucld on 8/5/20.
//  Copyright © 2020 phucledien. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    @State private var presentAddNewItem = false
    @State private var showSignInForm = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM) { task in
                            self.taskListVM.updateTask(task: task)
                        }
                    }
                    
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("Add New Task")
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showSignInForm) {
                SignInView()
            }
        .navigationBarItems(trailing:
            Button(action: { self.showSignInForm.toggle() }) {
               Image(systemName: "person.circle")
            })
            .navigationBarTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel

    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.completionStateIconName)
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                    self.onCommit(self.taskCellVM.task)
            }
           
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}
