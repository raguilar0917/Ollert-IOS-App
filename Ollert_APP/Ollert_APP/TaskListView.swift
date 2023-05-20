import SwiftUI

struct TaskListView: View {
    let title: String
    @Binding var tasks: [Task]
    @Binding var refresh: Bool
    let currentPage: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredTasks) { task in
                    Text(task.name)
                }
                .onDelete { indexSet in
                    deleteTasks(at: indexSet)
                }
            }
            .navigationTitle(title)
            .navigationBarItems(trailing: addButton)
            .id(refresh) // Reload the view when refresh is true
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
    
    private func deleteTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        refresh.toggle() // Toggle refresh to trigger view refresh
    }
}
