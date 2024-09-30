//
//  Schedule.swift
//  TitanTeam
//
//  Created by Deem Ibrahim on 27/03/1446 AH.
//

import SwiftUI

struct Schedule: View {
    var body: some View {

        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Spacer(minLength: 100)
                
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            HStack{
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: {  })
            }
            .padding()
            Spacer()
        }
            
        
            
            //        Table(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Collection@*/ /*@END_MENU_TOKEN@*/) {
            //            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/ /*@END_MENU_TOKEN@*/
            //        }
            Text("Genius is one percent inspiration, 99% perspiration \n")
            Image(systemName: "plus.circle").resizable()
            .frame(width: 50, height: 50)
            
        }
    }

#Preview {
    Schedule()
}
