# Ollert-IOS-App
Description:
For our project, we made a productivity app that helps users keep track of their tasks and the progress they have made on those tasks. Users can organize their tasks based on what they need to complete, what they are currently working on, and what they have completed. The app also has a pomodoro timer feature for when the user is currently working on one of their tasks and need to stay focused. 

How to Use:
Upon opening the app you’ll see the main content view three different lists: “Need to do”, “Currently doing”, and “Finished tasks”. The user can navigate between these three lists using the tab bar at the bottom of the view.

Tapping the the “+” icon at the top right corner will allow you to create a new task for any of the three lists. This will open up AddTaskView. On this view, the user can create a new task. They set the name, the subject, the due date, which list/page the task belongs to and a description of the task.

Once you have a task, you can tap it to open up the TaskDetailView. This view just displays all the information you previously entered. There are two buttons “Edit Task” and “Start Pomodoro”. “Edit task” will take you back to the AddTaskView and you can change the task information. “Start Pomodoro” will start a pomodoro timer. This is just a timer feature that the user can use to focus on task they’re currently working on. The idea is that they focus for 25 min on the task and take 5 min break at the end of the 25 min. They can repeat this as many times as they want. 

To delete a task, the user can simply find it in one of the lists in the main content view. They tap and hold the task until the delete option appears and they tap delete. The task should no longer appear in the list. 
