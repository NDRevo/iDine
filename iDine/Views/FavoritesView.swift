//
//  FavoritesView.swift
//  iDine
//
//  Created by Noe Duran on 4/22/21.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        NavigationView{
            List {
                ForEach(userSession.getUserFavorites()){ favorite in
                    NavigationLink(destination: ItemDetail(item: favorite)){
                        ItemRow(item: favorite)
                    }
                }
                .onDelete(perform: { indexSet in
                    userSession.removeFavorite(at: indexSet)
                })
            }
            .navigationTitle("Favorites")
            .listStyle(InsetGroupedListStyle())
            .toolbar(content: {
                if let userFavorites = userSession.getUserFavorites() {
                    if userFavorites.count > 0 {
                        EditButton()
                    }
                }
            })
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(UserSession())
    }
}
