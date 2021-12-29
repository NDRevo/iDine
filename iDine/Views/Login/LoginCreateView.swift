//
//  LoginCreateView.swift
//  iDine
//
//  Created by Noe Duran on 5/25/21.
//

import SwiftUI

struct LoginCreateView: View {
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        if userSession.isUserLoggedIn {
            ProfileView()
        } else {
            LoginView()
        }
    }
}

struct LoginCreateView_Previews: PreviewProvider {
    static var previews: some View {
        LoginCreateView()
    }
}
