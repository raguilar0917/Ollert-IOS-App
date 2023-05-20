//
//  TaskDetailView.swift
//  Ollert_APP
//
//  Created by Richard Aguilar on 5/20/23.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var tasks: [Task]
    
    let task: Task
    
    // Editable task properties
    @State private var editedName: String
    @State private var editedSubject: String
    @State private var editedDueDate: Date
    @State private var editedDescription: String
    @State private var editedCurrentPage: String
    
    @State private var isEditing = false // Add this line
    
    init(task: Task, tasks: Binding<[Task]>) {
        self.task = task
        self._tasks = tasks
        
        // Initialize editable task properties with the current task values
        self._editedName = State(initialValue: task.name)
        self._editedSubject = State(initialValue: task.subject)
        self._editedDueDate = State(initialValue: task.dueDate)
        self._editedDescription = State(initialValue: task.description)
        self._editedCurrentPage = State(initialValue: task.currentPage)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isEditing {
                // Editing mode UI
                VStack(alignment: .leading, spacing: 8) {
                    // Task Name
                    Text("Task Name")
                        .font(.headline)
                    TextField("Task Name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // Subject
                    Text("Subject")
                        .font(.headline)
                    TextField("Subject", text: $editedSubject)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // Due Date
                    Text("Due Date")
                        .font(.headline)
                    DatePicker("Due Date", selection: $editedDueDate, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                    
                    // Description
                    Text("Description")
                        .font(.headline)
                    TextEditor(text: $editedDescription)
                        .frame(height: 120)
                        .cornerRadius(8)
                        .border(Color.secondary, width: 1)
                    
                    // Current Page
                    Text("Current Page")
                        .font(.headline)
                    Picker("Current Page", selection: $editedCurrentPage) {
                        Text("Need to do").tag("Need to do")
                        Text("Currently doing").tag("Currently doing")
                        Text("Finished tasks").tag("Finished tasks")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    // Save the edited task
                    saveTask()
                    isEditing = false
                }) {
                    Text("Save Task")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom)
            } else {
                // View mode UI
                VStack(alignment: .leading, spacing: 8) {
                    // Task Name
                    Text(task.name)
                        .font(.title)
                    
                    // Subject
                    Text("Subject")
                        .font(.headline)
                    Text(task.subject)
                    
                    // Due Date
                    Text("Due Date")
                        .font(.headline)
                    Text(formattedDueDate)
                    
                    // Description
                    Text("Description")
                        .font(.headline)
                    Text(task.description)
                        .frame(maxHeight: .infinity)
                    
                    // Current Page
                    Text("Current Page")
                        .font(.headline)
                    Text(task.currentPage)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    isEditing = true
                }) {
                    Text("Edit Task")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("Task Detail")
        .navigationBarItems(trailing: closeButton)
    }
    
    private var formattedDueDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: task.dueDate)
    }
    
    private var closeButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
        }
    }
    
    private func saveTask() {
        // Find the index of the task in the tasks array
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        
        // Update the task with the edited values
        tasks[index].name = editedName
        tasks[index].subject = editedSubject
        tasks[index].dueDate = editedDueDate
        tasks[index].description = editedDescription
        tasks[index].currentPage = editedCurrentPage
    }
}
