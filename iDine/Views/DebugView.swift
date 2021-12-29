//
//  DebugScreen.swift
//  iDine
//
//  Created by Noe Duran on 5/26/21.
//

import SwiftUI

struct DebugView: View {
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        VStack {
            ForEach(userSession.userList) { member in
                Text(member.email)
            }
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
