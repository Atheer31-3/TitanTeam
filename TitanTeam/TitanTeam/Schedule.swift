import SwiftUI
import CalendarKit

struct Deem: View {
    let calendar = Calendar.current
    @State private var currentDate = Date()

    var body: some View {
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

            DatePicker("Select date", selection: $currentDate, displayedComponents: .date)
              

            TabView {
                // احصل على الشهر والسنة من التاريخ الحالي
                let month = calendar.component(.month, from: currentDate)
                let year = calendar.component(.year, from: currentDate)

                // عرض الشهر الحالي فقط
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

    @ViewBuilder
    func dayView(for day: Int, in monthDate: Date) -> some View {
        let dayDate = calendar.date(bySetting: .day, value: day, of: monthDate)!
        let dayName = calendar.weekdaySymbols[calendar.component(.weekday, from: dayDate) - 1]
        let dateString = "\(dayName) \(day)/\(calendar.component(.month, from: dayDate))"

        VStack(alignment: .center) {
            Text(dateString)
                .font(.headline)
                .padding()

            // مستطيل المهمة مع تأثير السكرول
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { index in // افترض وجود 3 مهام على سبيل المثال
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
            .frame(width: 100, height: 30) // يمكنك تعديل العرض كما تحتاج
            .background(Color.blue.opacity(0.3))
            .cornerRadius(5)
    }
}

#Preview {
    Deem()
}
