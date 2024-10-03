import SwiftUI
import CalendarKit

struct Schedule: View {
    let calendar = Calendar.current
    @State private var currentDate = Date()

    var body: some View {
        NavigationView {  // إضافة NavigationView
            VStack {
                HStack {
                    NavigationLink(destination: Sitting()) {
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

                DatePicker("Select date", selection: $currentDate, displayedComponents: .date)

                TabView {
                    let month = calendar.component(.month, from: currentDate)
                    let year = calendar.component(.year, from: currentDate)

                    VStack {
                        ScrollView {
                            VStack(spacing: 10) {
                                let monthDate = calendar.date(from: DateComponents(year: year, month: month))!
                                let daysInMonth = calendar.range(of: .day, in: .month, for: monthDate)!

                                ForEach(daysInMonth, id: \.self) { day in
                                    dayView(for: day, in: monthDate)
                                }
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 600)
                
                Text("Genius is one percent inspiration, 99% perspiration")
                
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
        }
    }

    @ViewBuilder
    func dayView(for day: Int, in monthDate: Date) -> some View {
        let dayDate = calendar.date(bySetting: .day, value: day, of: monthDate)!
        let dayName = calendar.weekdaySymbols[calendar.component(.weekday, from: dayDate) - 1]
        let dateString = "\(dayName) \(day)/\(calendar.component(.month, from: dayDate))"

        VStack(alignment: .center) {
            Text(dateString)
                .font(.headline)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { index in
                        taskView(task: "Task \(day) - \(index + 1)")
                            .padding(.horizontal, 5)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            .frame(height: 90)
        }
        .padding(5)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }

    func taskView(task: String) -> some View {
        Text(task)
            .frame(width: 100, height: 30)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(5)
    }
}

#Preview {
    Schedule()
}
