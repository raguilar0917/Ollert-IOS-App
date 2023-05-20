import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = [] // Initialize with your existing tasks
    @State private var refreshTasks = false
    @State private var showingAddTaskView = false
    
    var body: some View {
        TabView {
            TaskListView(title: "Need to do", tasks: $tasks, refresh: $refreshTasks, currentPage: "Need to do")
                .tabItem {
                    Label("Need to do", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
            
            TaskListView(title: "Currently doing", tasks: $tasks, refresh: $refreshTasks, currentPage: "Currently doing")
                .tabItem {
                    Label("Currently doing", systemImage: "arrow.right.circle")
                }
            
            TaskListView(title: "Finished tasks", tasks: $tasks, refresh: $refreshTasks, currentPage: "Finished tasks")
                .tabItem {
                    Label("Finished tasks", systemImage: "checkmark.circle")
                }
        }
        .sheet(isPresented: $showingAddTaskView) {
            AddTaskView(tasks: $tasks, refreshTasks: $refreshTasks)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
