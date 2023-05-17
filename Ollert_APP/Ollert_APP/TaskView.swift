//
//  TaskView.swift
//  Ollert
//
//  Created by Aakanksha Devarapally on 5/10/23.
//

import SwiftUI

struct TaskView: View {
    @State private var description: String = "This is a placeholder description for a task"
    @State private var start_date = Date()
    @State private var end_date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("TaskName Here").padding()
            // implement move to different list
            Section(header:Text("Description:").padding()) {
                TextField("Description", text: $description).padding()
                DatePicker("Start Date", selection: $start_date).padding()
                DatePicker("End Date", selection: $end_date).padding()
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
