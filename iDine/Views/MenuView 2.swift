//
//  MenuView.swift
//  iDine
//
//  Created by Noe Duran on 4/20/21.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var userSession: UserSession
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List{
                    ForEach(menu){ section in
                        Section(header: Text(section.name)){
                            ForEach(section.items){ item in
                                NavigationLink(destination: ItemDetail(item: item), isActive: $userSession.isMenuActive){
                                    ItemRow(item: item)
                                }
                                .swipeActions(edge: .leading){
                                    Button {
                                        if !userSession.isFavorited(item: item){
                                            userSession.addFavorite(item: item)
                                        } else {
                                            userSession.removeFavorite(item: item)
                                        }
                                    } label: {
                                        if userSession.isFavorited(item: item) {
                                            Label("Favorite", systemImage: "star.slash.fill")
                                        } else {
                                            Label("Not Favorite", systemImage: "star.fill")
                                        }
                                    }
                                    .tint(Color.yellow)
                                    .disabled(!userSession.isUserLoggedIn)
                                }
                                .swipeActions(edge: .trailing){
                                    Button {
                                        userSession.addOrder(item: item)
                                    } label: {
                                        Label("Add to Order", systemImage: "bag.fill.badge.plus")
                                    }
                                    .tint(Color.green)
                                }
                                
                            }
                        }
                    }
                }
                .navigationTitle("Menu")
                .listStyle(InsetGroupedListStyle())

                if let _ = userSession.mostRecentOrder, userSession.showOrderAdded {
                    AddedToOrder()
                        .zIndex(1)
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
