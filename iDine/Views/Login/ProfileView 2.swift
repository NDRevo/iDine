//
//  ProfileView.swift
//  iDine
//
//  Created by Noe Duran on 5/26/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userSession: UserSession
    @State var isWarningPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 42) {
            Spacer()
            Button(action: {
                userSession.signOutUser()
            }, label: {
                Text("Sign Out").frame(maxWidth: 300)
            })
            .buttonStyle(.bordered)
            .tint(.blue)
            .controlSize(.large)
            .headerProminence(.standard)
            
            Button(action: {
                isWarningPresented = true
            }, label: {
                Text("Delete Account").frame(maxWidth: 300)
            })
            .buttonStyle(.bordered)
            .tint(.red)
            .controlSize(.large)
            .headerProminence(.increased)
            .confirmationDialog(
                "Are you sure?",
                isPresented: $isWarningPresented){
                Button(role: .destructive){
                    userSession.removeUser()
                } label: {
                    Text("Confirm Delete Account")
                }
                
            }
            
        }
        .padding(.bottom, 42)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
