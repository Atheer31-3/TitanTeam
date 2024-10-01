
import SwiftUI

struct Sitting: View {
    @State private var showPersonalPage: Bool = false
    @State private var notificationsOn: Bool = false
    @State private var showAboutUs: Bool = false
    @State private var name: String = ""
//    let scrums: [Sitting]
    
    var body: some View {
        HStack {
            Button(action: {
                // Back action
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                Text("schedule")
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding()

        Text("Sitting")
            .font(.system(size: 40, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        
//            Divider()
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

                 
                       if showPersonalPage {
                           ZStack(alignment: .trailing) {
                               // TextField for name input
                               TextField("Enter your name", text: $name)
                                   .textFieldStyle(RoundedBorderTextFieldStyle())
                                   .padding(.leading)

                               
                               if !name.isEmpty {
                                   Button(action: {
                            // Clear the text in the text field when the button is clicked
                                       
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
                       }

                  Divider()
                
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
                    Text("We are a Titan Team ")
                        .padding(.leading)
                        .transition(.slide)
                }
                
                Divider()
            }
        }



#Preview {
    Sitting()
}
