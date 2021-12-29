//
//  MainView.swift
//  iDine
//
//  Created by Noe Duran on 4/21/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userSession: UserSession

    @Binding var currentTab: AppTabs?
    
    var body: some View {
        TabView(selection: Binding<AppTabs>(get: { return self.currentTab ?? .menu}, set: {self.currentTab = $0})){
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .tag(AppTabs.menu)
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(AppTabs.favorites)
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
                .tag(AppTabs.order)
                .badge(userSession.orderItems.count)
            LoginCreateView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(AppTabs.profile)
            DebugView()
                .tabItem {
                    Label("Debug", systemImage: "ant.fill")
                }
                .tag(AppTabs.debug)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(currentTab: .constant(.menu))
            .environmentObject(UserSession())
    }
}
