//
//  iDineApp.swift
//  iDine
//
//  Created by Noe Duran on 4/20/21.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var userSession = UserSession()
    
    var body: some Scene {
        WindowGroup {
            MainView(currentTab: $userSession.currentTab)
                .environmentObject(userSession)
        }
    }
}
