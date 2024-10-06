//
//  Edit.swift
//  Tasks
//
//  Created by khuloud nasser on 02/04/1446 AH.
//
import SwiftUI
import SwiftData

struct Edit: View {
    @State private var taskName: String = ""
    @State private var steps: [String] = Array(repeating: "", count: 3)
    @State private var stepCompletion: [Bool] = Array(repeating: false, count: 3)
    @State private var selectedDate = Date()
    @State private var sliderValue: Double = 0.0
    @State private var showDatePicker = false // حالة التحكم في إظهار التقويم
    @Environment(\.modelContext) private var modelContext

    // State variable for navigation
    @State private var navigateToTask = false // متغير حالة التنقل إلى Task

    var body: some View {
        NavigationView { // Wrap the content in a NavigationView
            VStack {
                // Header with back button
                HStack {
                    Button(action: {
                        // Action for back button
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                        Text("Schedule")
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding()

                // Add Task Title
                Text("Edit")
                    .font(.system(size: 40, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Task Name Input
                TextField("Create New Task", text: $taskName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Steps Section
                VStack {
                    HStack {
                        Text("Steps")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        // Add Step Button
                        Button(action: {
                            steps.append("")
                            stepCompletion.append(false)
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing)

                        // أيقونة التقويم لعرض DatePicker
                        Button(action: {
                            showDatePicker.toggle() // إظهار أو إخفاء التقويم
                        }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing)
                    }

                    // عرض التقويم عند الضغط على أيقونة "التقويم"
                    if showDatePicker {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    // List of Steps
                    ForEach(steps.indices, id: \.self) { index in
                        HStack {
                            // Step Completion Toggle Button
                            Button(action: {
                                stepCompletion[index].toggle()
                            }) {
                                Image(systemName: stepCompletion[index] ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(stepCompletion[index] ? .green : .gray)
                            }

                            // Step Input Field
                            TextField("Step \(index + 1)", text: $steps[index])
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)

                            // Remove Step Button
                            Button(action: {
                                steps.remove(at: index)
                                stepCompletion.remove(at: index)
                            }) {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Custom Slider Section
                HStack {
                    Image(systemName: "butterfly").foregroundColor(.yellow)

                    GeometryReader { geometry in
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.yellow.opacity(0.5))
                                .frame(height: 4)

                            Slider(value: $sliderValue, in: 0...1, step: 0.01)
                                .opacity(0)

                            Image("butterfly")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .offset(x: CGFloat(sliderValue) * (geometry.size.width - 30))
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let dragLocation = value.location.x
                                            let newValue = min(max(dragLocation / geometry.size.width, 0), 1)
                                            sliderValue = newValue
                                        }
                                )
                        }
                        .frame(height: 30)
                    }
                    .padding()

                    Text(" \(Int(sliderValue * 6))").padding()
                }
                .padding(.horizontal)

                // Save Task Button (Action to save the task)
                Button(action: {
                    // Create steps
                    let taskSteps = steps.enumerated().map { index, step in
                        Step(stepDescription: step, isCompleted: stepCompletion[index])
                    }
                    
                    // Create new task and save it to the database
                    let newTask = Task1(name: taskName, steps: taskSteps, date: selectedDate, priority: sliderValue)
                    modelContext.insert(newTask)
                    
                    do {
                        try modelContext.save()
                        print("Task saved successfully!")
                        navigateToTask = true // Navigate to Task page
                    } catch {
                        print("Failed to save task: \(error)")
                    }
                }) {
                    Text("Update")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .background(
                    NavigationLink(destination: Task(), isActive: $navigateToTask) {
                        EmptyView()
                    }
                    .hidden() // Keep it hidden
                )

                Spacer()
            }
        }
    }
}

#Preview {
    Edit()
}
