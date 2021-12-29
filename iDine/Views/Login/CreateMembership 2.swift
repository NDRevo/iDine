//
//  CreateMembership.swift
//  iDine
//
//  Created by Noe Duran on 5/25/21.
//

import SwiftUI

struct CreateMembership: View {
    @EnvironmentObject var userSession: UserSession
    
    @State private var isNotMatchingPassword: Bool = false
    @State private var isKeyboardShowing: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var optionalCode: String = ""
    let isEmployee = true
    
    var body: some View {
            VStack(spacing: 18) {
                Text("Create Account")
                    .font(.title)
                    .foregroundColor(.white)
                VStack(spacing: 8){
                    CustomTextField(title: "Email", keyboardType: .emailAddress, contentType: .emailAddress, inputtedText: $email)
                    CustomSecureTextField(title: "Password", contentType: .newPassword, inputtedText: $password)
                        .onTapGesture {
                            isNotMatchingPassword = false
                        }
                    CustomSecureTextField(title: "Confirm Password", contentType: .newPassword, inputtedText: $confirmPassword)
                        .onTapGesture {
                            isNotMatchingPassword = false
                        }

                    if isNotMatchingPassword {
                        Text("Passwords Don't Match")
                            .accentColor(Color.red)
                    }
                    
                    CustomSecureTextField(title: "Optional Code", contentType: .postalCode, inputtedText: $optionalCode)
                        .padding(.top, 24)
                }
                Button(action: {
                    if !email.isEmpty, !password.isEmpty {
                        let newUser = MemberInfo(id: UUID(),email: email, password: password, isEmployee: isEmployee, loyaltyNumber: Int.random(in: 100000..<999999))

                        if confirmPassword == password {
                            userSession.signUpUser(newUser)
                        } else {
                            password.removeAll()
                            confirmPassword.removeAll()
                            isNotMatchingPassword = true
                        }
                    }
                }, label: {
                    Text("Sign Up")
                })
                .buttonStyle(.bordered)
                .controlSize(.large)
                .headerProminence(.increased)
                .tint(.blue)
                Spacer()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                isKeyboardShowing = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                isKeyboardShowing = false
            }
            .frame(maxWidth: 320)
            .padding(.horizontal, 25)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isKeyboardShowing {
                        Button(action: {
                            self.dismissKeyboard()
                            isKeyboardShowing = false
                        }, label: {
                            Text("Cancel")
                        })
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        userSession.isCreateMembershipVisible = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                }
            }
    }
}

#if canImport(UIKit)
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct CreateMembership_Previews: PreviewProvider {
    static var previews: some View {
        CreateMembership()
    }
}
