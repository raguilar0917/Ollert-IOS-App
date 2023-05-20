import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var tasks: [Task]
    @Binding var refreshTasks: Bool
    
    @State private var taskName = ""
    @State private var subject = ""
    @State private var dueDate = Date()
    @State private var currentPage = "Need to do"
    @State private var description = ""
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $taskName)
                TextField("Subject", text: $subject)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                Picker("Current Page", selection: $currentPage) {
                    Text("Need to do").tag("Need to do")
                    Text("Currently doing").tag("Currently doing")
                    Text("Finished tasks").tag("Finished tasks")
                }
            }
            
            Section(header: Text("Description")) {
                TextEditor(text: $description)
            }
            
            Section {
                Button(action: {
                    let task = Task(name: taskName, subject: subject, dueDate: dueDate, currentPage: currentPage, description: description)
                    saveTask(task, tasks: &tasks, refreshTasks: &refreshTasks)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Task")
                }

            }
        }
        .navigationTitle("Add New Task")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(tasks: .constant([]), refreshTasks: .constant(false))
    }
}
