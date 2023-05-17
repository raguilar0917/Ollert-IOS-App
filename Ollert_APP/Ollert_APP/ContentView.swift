//
//  ContentView.swift
//  Ollert
//
//  Created by Aakanksha Devarapally on 5/9/23.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var description: String = ""
    var status: statuses = statuses.other
}
enum statuses: String, CaseIterable {
    case upcoming = "Upcoming"
    case pending = "Pending"
    case completed = "Completed"
    case other
}
var tasks = [Task(name:"Task", status: statuses.completed), Task(name: "Task", status: statuses.upcoming), Task(name: "Task", status: statuses.pending)]

func CreateNewTask(taskName: String, taskStatus: statuses) {
    let newTask = Task(name: taskName, status: taskStatus)
    tasks.append(newTask)
}


struct ContentView: View {
    
    var upcomingTasks: [Binding<Task>] {
        tasks
            .filter { $0.status == .upcoming }
            .map { task in
                Binding<Task>(
                    get: {
                        tasks.first(where: { $0.id == task.id })!
                    },
                    set: { updatedTask in
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks[index] = updatedTask
                        }
                    }
                )
            }
    }
    
    var pendingTasks: [Binding<Task>] {
        tasks
            .filter { $0.status == .pending }
            .map { task in
                Binding<Task>(
                    get: {
                        tasks.first(where: { $0.id == task.id })!
                    },
                    set: { updatedTask in
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks[index] = updatedTask
                        }
                    }
                )
            }
    }
    
    var completedTasks: [Binding<Task>] {
        tasks
            .filter { $0.status == .completed }
            .map { task in
                Binding<Task>(
                    get: {
                        tasks.first(where: { $0.id == task.id })!
                    },
                    set: { updatedTask in
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks[index] = updatedTask
                        }
                    }
                )
            }
    }
    
    @State private var text1: String = ""
    @State private var text2: String = ""
    @State private var text3: String = ""
    
    var body: some View {
        TabView {
            List {
                Section(header: Text("Upcoming")) {
                    ForEach(upcomingTasks, id: \.wrappedValue.id) { taskBinding in
                        Text(taskBinding.wrappedValue.name)
                            .onTapGesture {
                                //OpenTaskView();
                            }
                    }
                    VStack {
                        TextField("Add Task", text: $text1, onCommit: {
                            CreateNewTask(taskName: text1, taskStatus: statuses.upcoming)
                        })
                    }
                }
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Upcoming")
                }
            }
                List {
                    Section(header: Text("Pending")) {
                        ForEach(pendingTasks, id: \.wrappedValue.id) { taskBinding in
                            Text(taskBinding.wrappedValue.name)
                                .onTapGesture {
                                    //OpenTaskMenu();
                                }
                        }
                        VStack {
                            TextField("Add Task", text: $text2, onCommit: {
                                CreateNewTask(taskName: text2, taskStatus: statuses.pending)
                            })
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Pending")
                }
                List {
                    Section(header: Text("Completed")) {
                        ForEach(completedTasks, id: \.wrappedValue.id) { taskBinding in
                            Text(taskBinding.wrappedValue.name)
                                .onTapGesture {
                                    //OpenTaskMenu();
                                }
                        }
                        VStack {
                            TextField("Add Task", text: $text3, onCommit: {
                                CreateNewTask(taskName: text3, taskStatus: statuses.completed)
                            })
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Completed")
                }
            }
            .tabViewStyle(.page)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


