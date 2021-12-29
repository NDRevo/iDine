//
//  ItemDetail.swift
//  iDine
//
//  Created by Noe Duran on 4/21/21.
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var userSession: UserSession
    
    let item: MenuItem
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(spacing: 0){
                ZStack(alignment: .bottomTrailing){
                    Image(item.mainImage)
                        .resizable()
                        .scaledToFit()
                    Text("Photo: \(item.photoCredit)")
                        .padding(4)
                        .background(Color.black)
                        .cornerRadius(4)
                        .foregroundColor(.white)
                        .font(.caption)
                        .offset(x: -5, y: -5)
                }
                List{
                    Section(header: Text("Description")){
                        Text(item.description)
                            .padding()
                    }
                    Section {
                        Button {
                            print("IM IN AR")
                        } label: {
                            HStack {
                                Image(systemName: "arkit")
                                Text("View in AR")
                            }
                        }
                        if userSession.currentTab != .favorites && userSession.isUserLoggedIn{
                            Button {
                                if !userSession.isFavorited(item: item){
                                    userSession.addFavorite(item: item)
                                } else {
                                    userSession.removeFavorite(item: item)
                                }
                            } label: {
                                HStack {
                                    Image(systemName: userSession.isFavorited(item: item) ? "star.fill" : "star")
                                    Text("Add To Favorites")
                                }
                            }
                        }
                    }
                    Section {
                        Button(action: {
                            userSession.addOrder(item: item)
                        }, label: {
                            Text("Order")
                                .foregroundColor(.blue)
                        })
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            if userSession.showOrderAdded {
                AddedToOrder()
                    .zIndex(1)
           }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ItemDetail(item: MenuItem.example)
                .environmentObject(UserSession())
        }
    }
}
