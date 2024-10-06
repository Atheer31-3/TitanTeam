import SwiftUI

struct Task: View {
    @State private var tasksList: [[TaskModel]] = [
        [TaskModel(text: "Task 1.1"), TaskModel(text: "Task 1.2"), TaskModel(text: "Task 1.3"), TaskModel(text: "Task 1.4"), TaskModel(text: "Task 1.5"), TaskModel(text: "Task 1.6"), TaskModel(text: "Task 1.7"), TaskModel(text: "Task 1.8")],
        [TaskModel(text: "Task 2.1"), TaskModel(text: "Task 2.2")],
        [TaskModel(text: "Task 3.1"), TaskModel(text: "Task 3.2")],
        [TaskModel(text: "Task 4.1"), TaskModel(text: "Task 4.2")]
    ]
    
    let images = ["butterfly1", "butterfly2", "butterfly3", "butterfly4", "butterfly5", "butterfly6", "butterfly7", "butterfly8"]

    @State private var selectedTab: String = "Task"

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // الرموز في الأعلى (لليوزر والتنبيهات)
                    HStack {
                        NavigationLink(destination: Sitting()) { // Navigate to Sitting
                            Image(systemName: "person.circle")
                                .font(.largeTitle)
                                .padding(.leading)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "bell")
                            .font(.largeTitle)
                            .padding(.trailing)
                    }
                    .padding(.top, 40)
                    .padding(.horizontal)
                    .background(Color.white)
                    .zIndex(2)

                    // التبويبات بين "Task" و "Schedule"
                    HStack(spacing: 0) {
                        Button(action: {
                            selectedTab = "Schedule"
                        }) {
                            Text("Schedule")
                                .font(.system(size: 16))
                                .foregroundColor(selectedTab == "Schedule" ? .black : .gray)
                                .frame(width: 80, height: 30)
                                .background(selectedTab == "Schedule" ? Color.gray.opacity(0.2) : Color.clear)
                        }
                        
                        Button(action: {
                            selectedTab = "Task"
                        }) {
                            Text("Task")
                                .font(.system(size: 16))
                                .foregroundColor(selectedTab == "Task" ? .black : .gray)
                                .frame(width: 80, height: 30)
                                .background(selectedTab == "Task" ? Color.gray.opacity(0.2) : Color.clear)
                        }
                    }
                    .cornerRadius(5)
                    .padding(.top, 20)

                    // محتوى التبويبات
                    if selectedTab == "Task" {
                        // عرض المهام
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 50) {
                                ForEach(0..<tasksList.count, id: \.self) { taskIndex in
                                    if !tasksList[taskIndex].isEmpty {
                                        TaskCardView(tasks: $tasksList[taskIndex], taskIndex: taskIndex, images: images, tasksList: $tasksList)
                                    }
                                }
                            }
                            .padding()
                        }
                    } else {
                        // عرض جدول المواعيد
                        Text("This is the Schedule View") // يمكن استبداله بمحتوى جدول المواعيد
                    }

                    Spacer()
                }

                // زر إضافة مهمة جديدة
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
}

struct TaskCardView: View {
    @Binding var tasks: [TaskModel]
    var taskIndex: Int
    let images: [String]
    @Binding var tasksList: [[TaskModel]]

    @State private var cardOpacity: Double = 1.0
    @State private var showDeleteConfirmation: Bool = false // حالة للتحكم في التنبيه

    // التاريخ بشكل نصي (اليوم، اسم الشهر، السنة)
    var fullDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy" // التنسيق كاليوم واسم الشهر والسنة
        return formatter.string(from: Date())
    }

    var body: some View {
        VStack(alignment: .leading) {
            // العنوان "Task"
            TextField("Enter Task Title", text: Binding(
                get: { "Task \(taskIndex + 1)" },
                set: { _ in }
            ))
            .font(.headline)
            .padding(.bottom, 5)

            // داخل المربع الأبيض (التاريخ وزر التعديل أعلى قائمة المهام)
            VStack(spacing: -2) {
                HStack {
                    // عرض التاريخ (اليوم، اسم الشهر، السنة)
                    Text(fullDate)
                        .font(.caption)
                        .foregroundColor(.gray)

                    Spacer()

                    // زر التعديل (قلم)
                    Button(action: {
                        // الأكشن المطلوب عند الضغط على زر التعديل
                        print("Edit all tasks in group tapped")
                    }) {
                        Image(systemName: "pencil")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 5) // مسافة صغيرة بين التاريخ وزر التعديل والمهام

                // قائمة المهام
                ForEach(0..<tasks.count, id: \.self) { subtaskIndex in
                    TaskRow(task: $tasks[subtaskIndex], imageName: imageForTask(at: subtaskIndex, in: tasks.count), tasks: $tasks, tasksList: $tasksList, taskIndex: taskIndex, cardOpacity: $cardOpacity, showDeleteConfirmation: $showDeleteConfirmation)
                }
            }
            .padding()
            .background(Color.white) // المربع الأبيض الذي يحتوي على كل شيء
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .opacity(cardOpacity)
        .frame(width: 300)
        .padding(.horizontal)
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("هل تريد حذف المهمة؟"),
                message: Text("لن يمكنك التراجع عن هذا الإجراء."),
                primaryButton: .destructive(Text("حذف")) {
                    deleteTask()
                },
                secondaryButton: .cancel(Text("تراجع"))
            )
        }
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

    func deleteTask() {
        withAnimation(.easeOut(duration: 1)) {
            cardOpacity = 0 // إخفاء البطاقة
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            tasksList[taskIndex].removeAll() // حذف المهمة بالكامل
        }
    }
}

struct TaskRow: View {
    @Binding var task: TaskModel
    var imageName: String
    @Binding var tasks: [TaskModel]
    @Binding var tasksList: [[TaskModel]]
    var taskIndex: Int
    @Binding var cardOpacity: Double
    @Binding var showDeleteConfirmation: Bool

    var body: some View {
        HStack {
            Button(action: {
                task.completed.toggle()
                checkIfAllTasksCompleted()
            }) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .opacity(task.completed ? 1.0 : 0.3)
            }
            Text(task.text.isEmpty ? "Task will be added here" : task.text)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            
            Spacer()
        }
        .padding(.vertical, 5)
    }
    
    func checkIfAllTasksCompleted() {
        // إذا تم الانتهاء من جميع الفراشات، يعرض رسالة التأكيد قبل حذف المهمة
        if tasks.allSatisfy({ $0.completed }) {
            showDeleteConfirmation = true
        }
    }
}

// TaskModel لتعريف البيانات
struct TaskModel {
    var text: String
    var completed: Bool = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Task()
    }
}
