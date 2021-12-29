//
//  LoginView.swift
//  iDine
//
//  Created by Noe Duran on 5/25/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userFound = true
    @FocusState private var focusField: Field?
    
    enum Field: Hashable {
        case email
        case password
    }
    
    func beginLogin(){
        let user = MemberInfo(email: email, password: password)
        
        if email.isEmpty {
            focusField = .email
        } else if password.isEmpty {
            focusField = .password
        } else {
            if let foundUser = userSession.getUser(user: user) {
                userSession.logInUser(user: foundUser)
            } else {
                userFound = false
            }
        }
    }

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 120)
                .accentColor(.blue)
            Text("Incorrect email or password")
                .isHidden(userFound)
            VStack(spacing: 8){
                CustomTextField(title: "Email", keyboardType: .emailAddress, contentType: .emailAddress, inputtedText: $email)
                    .onTapGesture {userFound = true}
                    .focused($focusField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .password
                    }
                CustomSecureTextField(title: "Password", contentType: .password, inputtedText: $password)
                    .onTapGesture {userFound = true}
                    .focused($focusField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit {
                        dismissKeyboard()
                    }
            }
            HStack {
                Button(action: {
                    beginLogin()
                }, label: {
                    Text("Login").frame(maxWidth: 325)
                })
                .buttonStyle(.bordered)
                .tint(.blue)
                .controlSize(.large)
                .headerProminence(.standard)
                
                Button(action: {
                    userSession.isCreateMembershipVisible = true
                    focusField = nil
                }, label: {
                    Text("Create Account").frame(maxWidth: 325)
                })
                .buttonStyle(.bordered)
                .tint(.green)
                .controlSize(.large)
                .headerProminence(.standard)
                .sheet(isPresented: $userSession.isCreateMembershipVisible){
                    NavigationView {
                        CreateMembership()
                    }
                    .accentColor(Color.gray)
                }
            }
            Spacer()
        }
        .frame(maxWidth: 325)
        .padding(.horizontal, 25)
        .padding(.top, 64)
    }
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View{
        if hidden {
            self.hidden()
          } else {
            self
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserSession())
    }
}
