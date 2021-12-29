//
//  AddedToOrder.swift
//  iDine
//
//  Created by Noe Duran on 6/6/21.
//

import SwiftUI

struct AddedToOrder: View {
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        HStack {
            Text("Added \(userSession.mostRecentOrder?.name ?? "Missing Item") to order!")
            Spacer()
            Text("$\(userSession.mostRecentOrder?.price ?? 0)")
        }
        .font(.body.weight(.semibold))
        .padding(14)
        .background(Color.green)
        .cornerRadius(12)
        .background(
            RoundedRectangle(cornerRadius: 9)
                .fill(Color.black)
                .opacity(0.2)
                .blur(radius: 12)
                .offset(y: 10)
                .padding(2)
        )
        .onTapGesture {
            userSession.currentTab = .order
        }
        .transition(.opacity)
        .padding(.horizontal, 16)
        .padding(.bottom, 28)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    userSession.showOrderAdded = false
                }
            }
        }
    }
}

struct AddedToOrder_Previews: PreviewProvider {
    static var previews: some View {
        AddedToOrder()
    }
}
