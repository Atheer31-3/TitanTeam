import SwiftUI

struct ContentView: View {
    @State private var tasksList: [[TaskModel]] = [
        [TaskModel(text: "Task 1.1"), TaskModel(text: "Task 1.2"), TaskModel(text: "Task 1.3"), TaskModel(text: "Task 1.4"), TaskModel(text: "Task 1.5"), TaskModel(text: "Task 1.6"), TaskModel(text: "Task 1.7"), TaskModel(text: "Task 1.8")],
        [TaskModel(text: "Task 2.1"), TaskModel(text: "Task 2.2")],
        [TaskModel(text: "Task 3.1"), TaskModel(text: "Task 3.2")],
        [TaskModel(text: "Task 4.1"), TaskModel(text: "Task 4.2")]
    ]
    
    let images = ["butterfly1", "butterfly2", "butterfly3", "butterfly4", "butterfly5", "butterfly6", "butterfly7", "butterfly8"]

    @State private var selectedTab: String = "Task"

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.largeTitle)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "bell")
                        .font(.largeTitle)
                        .padding(.trailing)
                }
                .padding(.top, 40)
                .padding(.horizontal)
                .background(Color.white)
                .zIndex(2)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<tasksList.count, id: \.self) { taskIndex in
                            if !tasksList[taskIndex].allSatisfy({ $0.completed }) {
                                TaskCardView(tasks: $tasksList[taskIndex], taskIndex: taskIndex, images: images, tasksList: $tasksList)
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }

            VStack {
                Spacer()
                
                Button(action: {
                    // Action to add new task
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.black)
                        .padding(.bottom, 30)
                }
                .zIndex(2)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct TaskCardView: View {
    @Binding var tasks: [TaskModel]
    var taskIndex: Int
    let images: [String]
    @Binding var tasksList: [[TaskModel]]
    
    @State private var butterflyFlyAway = false
    @State private var butterflyOffset: CGSize = .zero

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter Task Title", text: Binding(
                get: { "Task \(taskIndex + 1)" },
                set: { _ in }
            ))
            .font(.headline)
            .padding(.bottom, 5)

            VStack(spacing: 10) {
                ForEach(0..<tasks.count, id: \.self) { subtaskIndex in
                    TaskRow(task: $tasks[subtaskIndex], imageName: imageForTask(at: subtaskIndex, in: tasks.count), tasks: $tasks, tasksList: $tasksList, taskIndex: taskIndex, butterflyFlyAway: $butterflyFlyAway, butterflyOffset: $butterflyOffset)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .frame(width: 300)
        .padding(.horizontal)
    }
    
    func imageForTask(at index: Int, in totalTasks: Int) -> String {
        if totalTasks == 1 {
            return images.last!
        } else if index == 0 {
            return images.first!
        } else if index == totalTasks - 1 {
            return images.last!
        } else {
            let middleImages = Array(images[1..<(images.count - 1)])
            return middleImages[index % middleImages.count]
        }
    }
}

struct TaskRow: View {
    @Binding var task: TaskModel
    var imageName: String
    @Binding var tasks: [TaskModel]
    @Binding var tasksList: [[TaskModel]]
    var taskIndex: Int
    
    @Binding var butterflyFlyAway: Bool
    @Binding var butterflyOffset: CGSize

    var body: some View {
        HStack {
            Button(action: {
                if taskIndex == tasks.count - 1 && task.completed == false {
                    withAnimation(.easeInOut(duration: 2)) {
                        butterflyFlyAway = true
                        butterflyOffset = CGSize(width: 100, height: -600) // تحريك الفراشة خارج الشاشة
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        tasksList[taskIndex].removeAll()
                    }
                } else {
                    task.completed.toggle()
                }
            }) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .opacity(task.completed ? 1.0 : 0.3)
                    .offset(butterflyFlyAway ? butterflyOffset : .zero) // إزاحة الفراشة عند الطيران
            }

            TextField("Enter subtask", text: $task.text)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            
            Spacer()
        }
        .padding(.vertical, 5)
    }
}

struct TaskModel {
    var text: String
    var completed: Bool = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
