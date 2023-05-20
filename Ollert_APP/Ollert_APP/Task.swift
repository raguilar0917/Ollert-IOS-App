import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var name: String
    var subject: String
    var dueDate: Date
    var currentPage: String
    var description: String
    var timerRunning: Bool = false
    var timerDuration: TimeInterval = 25 * 60 // Default timer duration is 25 minutes
    var timerProgress: TimeInterval = 0
}


extension Task: Equatable {}

func saveTask(_ task: Task, tasks: inout [Task], refreshTasks: inout Bool) {
    tasks.append(task)
    
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(tasks) {
        UserDefaults.standard.set(encoded, forKey: "Tasks")
        refreshTasks = true // Set refreshTasks to true to trigger view refresh
    }
}


func retrieveTasks() -> [Task] {
    let defaults = UserDefaults.standard
    if let savedTasks = defaults.data(forKey: "Tasks") {
        let decoder = JSONDecoder()
        if let loadedTasks = try? decoder.decode([Task].self, from: savedTasks) {
            return loadedTasks
        }
    }
    return []
}
