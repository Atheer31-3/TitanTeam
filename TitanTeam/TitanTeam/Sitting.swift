//
//  Sitting.swift
//  TitanTeam
//
//  Created by atheer alshareef on 06/10/2024.
//


import SwiftUI

struct Sitting: View {
    @State private var showPersonalPage: Bool = false
    @State private var notificationsOn: Bool = false
    @State private var showAboutUs: Bool = false
    @State private var name: String = ""
    let colors: [Color] = [.red, .yellow, .purple, .green, .brown]
    let interests = ["Self Confident", "Study", "Success", "Proverbs", "Funny", "Life"]
    @State var selectedColor: Color = .blue
    @State var selectedInterest: String? = nil
    @State var customColor: Color = .white
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        NavigationLink(destination: Sitting()) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                            Text("schedule")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    //.padding(.top)
                    .padding(.horizontal)
                    
                    
                    Text("Sitting")
                        .font(.system(size: 40, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Divider()
                    
                    Button(action: {
                        withAnimation {
                            showPersonalPage.toggle()
                        }
                    }) {
                        HStack {
                            Text("Profile")
                            Spacer()
                            Image(systemName: showPersonalPage ? "chevron.down" : "chevron.right")
                        }
                        .padding()
                    }
                    // her bign list profile
                    if showPersonalPage {
                        
                        // this Enter your name
                        ZStack(alignment: .trailing) {
                            TextField("Enter your name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(.gray)
                                .padding(.leading)
                            
                            if !name.isEmpty {
                                Button(action: {
                                    name = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .transition(.slide)
                        .padding(.bottom, 10)
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
//                            Divider()
                        }
                // Interest message buttons, Daily Interest Message
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
                        }
                        
                    }
                    Divider()
                    
                    // Toggle الإشعارات لازم اربطها مع الاشعارات
                    Toggle(isOn: $notificationsOn) {
                        Text("Notifications")
                    }
                    .padding()
                    
                    Divider()
                    
                 
                    Button(action: {
                        withAnimation {
                            showAboutUs.toggle()
                        }
                    }) {
                        HStack {
                            Text("About Us")
                            Spacer()
                            Image(systemName: showAboutUs ? "chevron.down" : "chevron.right")
                        }
                        .padding()
                    }
                    
                    if showAboutUs {
                        Text("We are a Titan Team")
                            .padding(.leading)
                            .transition(.slide)
                    }
                    
                    Divider()
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    Sitting()
}
//.navigationBarBackButtonHidden(true)
