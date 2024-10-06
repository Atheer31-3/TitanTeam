//
//  Schedule.swift
//  TitanTeam
//
//  Created by Sara Ali Alahmadi on 03/04/1446 AH.
//

import SwiftUI
import CalendarKit

struct Schedule: View {
    let calendar = Calendar.current
    @State private var currentDate = Date()
    @State private var selectedTopic = "SelfConfident"
    @State private var sentence = ""
    @State private var date = ""
    let interests = ["SelfConfident", "Study", "Success", "Proverbs", "Funny", "Life"]
        @State private var randomQuote: String = ""
    let topics = ["SelfConfident", "Study", "Success", "Proverbs", "Funny", "Life"]
    @Binding var selectedInterest: String? // Binding to accept value from Page3
    func getRandomQuote(for interest: String) -> String {
           switch interest {
           case "SelfConfident":
               return Intrist.SelfConfident.randomElement() ?? ""
           case "Study":
               return Intrist.Study.randomElement() ?? ""
           case "Success":
               return Intrist.Success.randomElement() ?? ""
           case "Proverbs":
               return Intrist.Proverbs.randomElement() ?? ""
           case "Funny":
               return Intrist.Funny.randomElement() ?? ""
           case "Life":
               return Intrist.Life.randomElement() ?? ""
           default:
               return ""
           }
       }
    var body: some View {

        NavigationView {
            VStack {
                // الشريط العلوي
                HStack {
                    NavigationLink(destination: Text("Profile")) {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                }
                          //DatePicker("", selection: $currentDate, displayedComponents: .date)
                DatePicker("", selection: $currentDate, displayedComponents: .date)
                                .padding()
                                .onChange(of: currentDate) { _ in
                                    // عند تغيير التاريخ، نعيد تعيين العبارة العشوائية
                                    if let selectedInterest = selectedInterest {
                                        randomQuote = getRandomQuote(for: selectedInterest)
                                    }
                                }
                               
                // TabView لعرض الأسابيع بشكل أفقي
                TabView {
                    ForEach(0..<4, id: \.self) { weekIndex in
                        weekView(startingFrom: weekIndex * 7)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // نص تحفيزي
                
               // Text("Genius is one percent inspiration, 99% perspiration")
                if !randomQuote.isEmpty {
                                Text(randomQuote)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                    .background(Color.yellow.opacity(0.3))
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                        
                        .navigationTitle("")
                        .onAppear {
                            if let selectedInterest = selectedInterest {
                                randomQuote = getRandomQuote(for: selectedInterest)
                            }
                        }
                // زر إضافة مهمة
                Button(action: {
                    // إضافة مهمة جديدة
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.black)
                        .padding(.bottom, 30)
                }
            }
        }
    }
    
    // عرض الأسبوع
    @ViewBuilder
    func weekView(startingFrom startDay: Int) -> some View {
        VStack(spacing: 10) {
            ForEach(0..<7, id: \.self) { dayOffset in
                let day = startDay + dayOffset + 1
                dayView(for: day)
            }
        }
        .padding()
    }
    
    // عرض اليوم مع المهام
    @ViewBuilder
    func dayView(for day: Int) -> some View {
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        let monthDate = calendar.date(from: DateComponents(year: year, month: month))!
        let dayDate = calendar.date(bySetting: .day, value: day, of: monthDate)!
        let dayName = calendar.weekdaySymbols[calendar.component(.weekday, from: dayDate) - 1]
        let dateString = "\(dayName) \(day)/\(calendar.component(.month, from: dayDate))"
        
        VStack(alignment: .leading, spacing: 10) {
            Text(dateString)
                  .font(.system(size: 16))
                  .bold()
                .padding(.leading, 5)
            
            // المهام
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<5) { index in
                        taskView(task: "Task \(day) - \(index + 1)")
                    }
                }
        
                .background(Color._7)
                .cornerRadius(10)
            }
 
        }

        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    // عرض المهمة
    func taskView(task: String) -> some View {
        Button(action: {
            // الإجراء المطلوب عند النقر على المهمة
            print("\(task)")
        }) {
            Text(task)
                .frame(width: 100, height: 30)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(5)
                .foregroundColor(.black) // الحفاظ على لون النص
        }
    }
}

#Preview {
    Schedule(selectedInterest: .constant(nil))
}
