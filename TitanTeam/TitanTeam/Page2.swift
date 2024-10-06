//
//  Page2.swift
//  SaraP1
//
//  Created by Sara Ali Alahmadi on 02/04/1446 AH.
//

import SwiftUI

struct Page2: View {
    var body: some View {
        NavigationStack {
            VStack{
                        Text("Do you want to do your sceudual?")
                            .font(.headline)
                           // .bold()
                
                        NavigationLink(destination: Page3()) {
                            Text("Design my Scedual")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 100.0)
                      //  NavigationLink(destination: Page1()) {
                            Text("Basic Scedual")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }
                }
        }
#Preview {
    Page2()
}
