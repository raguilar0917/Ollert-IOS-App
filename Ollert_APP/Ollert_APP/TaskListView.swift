import SwiftUI

struct TaskListView: View {
    let title: String
    @Binding var tasks: [Task]
    @Binding var refresh: Bool
    let currentPage: String
    
    @State private var selectedTask: Task?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredTasks) { task in
                    Button(action: {
                        selectedTask = task
                    }) {
                        Text(task.name)
                    }
                    .contextMenu {
                        Button(action: {
                            deleteTask(task)
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                        Button(action: {
                            switchTaskPage(task)
                        }) {
                            Label("Switch Page", systemImage: "arrow.right.square")
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(trailing: addButton)
            .id(refresh) // Reload the view when refresh is true
            .sheet(item: $selectedTask) { task in
                TaskDetailView(task: task, tasks: $tasks)
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            // Add action to navigate to the add task view
            guard let windowScene = UIApplication.shared.windows.first?.windowScene,
                  let window = windowScene.windows.first else {
                return
            }
            let addTaskView = AddTaskView(tasks: $tasks, refreshTasks: $refresh)

            let addTaskViewHostingController = UIHostingController(rootView: addTaskView)
            addTaskViewHostingController.modalPresentationStyle = .fullScreen
            window.rootViewController?.present(addTaskViewHostingController, animated: true, completion: nil)
        }) {
            Image(systemName: "plus.circle")
        }
    }
    
    private var filteredTasks: [Task] {
        return tasks.filter { $0.currentPage == currentPage }
    }
    
    private func deleteTask(_ task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
            refresh.toggle() // Toggle refresh to trigger view refresh
        }
    }
    
    private func switchTaskPage(_ task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].currentPage = currentPage
            refresh.toggle() // Toggle refresh to trigger view refresh
        }
    }
}
