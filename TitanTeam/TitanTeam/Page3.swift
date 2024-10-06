//
//  Page3.swift
//  TitanTeam
//
//  Created by Sara Ali Alahmadi on 03/04/1446 AH.
//

import SwiftUI

struct Page3: View {
    let colors: [Color] = [._1, ._2, ._3, ._4, ._5]
    let interests = ["Self Confident", "Study", "Success", "Proverbs", "Funny", "Life"]
    @State var selectedColor: Color = ._1
    @State var selectedInterest: String? = nil
    @State var customColor: Color = .white
    @State private var currentDate = Date()
    let topics = ["SelfConfident", "Study", "Success", "Proverbs", "Funny", "Life"]
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    NavigationLink {
                        Page2()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                            .bold()
                            .padding(.top)
                            .padding(.leading, 6.5)
                            Text("Back")
                            .padding(.top)
                            .padding(-4)
                    }
                    Spacer() // لإجبار المحتوى على المحاذاة لليسار
                }
                Text(" Design your schedule")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Color selection buttons
                VStack(alignment: .leading, spacing: 5) {
                    Text("  Colors")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Button(action: {
                                selectedColor = color
                            }) {
                                Circle()
                                    .fill(color)
                                    .frame(width: 25)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
                                )
                            }
                        }
                        .padding(.leading, 9)
                        ColorPicker("", selection: $customColor)
                            .labelsHidden()
                            .frame(width: 30, height: 35)
                            .onChange(of: customColor) { newValue in
                                selectedColor = newValue
                            }
                            .padding(.leading, 9)
                    }
                    Text("  choose or customize your color")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Divider()
                }
                // Interest message buttons
                VStack(alignment: .leading,spacing: 12) {
                    
                    Text("Daily Interest Message")
                        .font(.headline)
                        .padding(.leading,7)
                    
                    // Grid of interest buttons
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                        ForEach(interests, id: \.self) { interest in
                            Button(action: {
                                selectedInterest = interest // Update the selected interest
                            }) {
                                Text(interest)
                                    .padding()
                                    .frame(width: 120, height: 50)
                                    .background(
                                        selectedInterest == interest ? selectedColor : Color.white.opacity(0.3)
                                    )
                                    .cornerRadius(10)
                                    .foregroundColor(selectedInterest == interest ? .white : .black)
                                    .font(.system(size: 12, weight: .medium))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                        
                            }
                             
                        }
                        
                    }
                    .navigationTitle("")
                }
                NavigationLink(destination: Schedule(selectedInterest: $selectedInterest)) {
                    Text("Submit")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.top, 30.0)
                .padding(.horizontal, 100.0)
            }
        }
    }
}
#Preview {
    Page3()
}
