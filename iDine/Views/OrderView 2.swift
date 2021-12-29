//
//  OrderView.swift
//  iDine
//
//  Created by Noe Duran on 4/21/21.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var userSession: UserSession
    @State var isOrderMainActive: Bool = false
    @State var isConfirmDelete: Bool = false
    
    func deleteItems(at offsets: IndexSet){
        userSession.orderItems.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                Section{
                    ForEach(userSession.orderItems) { item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteItems(at: indexSet)
                    })
                }
                Section{
                    NavigationLink(
                        destination: CheckoutView(),
                        isActive: $userSession.isOrderActive,
                        label: {
                            Text("Place Order")
                        }
                    )
                }
                .disabled(userSession.orderItems.isEmpty)
                
                if userSession.orderItems.count >= 3 {
                    Section{
                        Button(role: .destructive){
                           isConfirmDelete = true
                        } label: {
                            Text("Clear Order")
                        }
                        .confirmationDialog("Delete Order?", isPresented: $isConfirmDelete) {
                            Button(role: .destructive){
                                userSession.orderItems = []
                            } label: {
                                Text("Confirm Clear Order")
                            }
                        }

                    }
                }
            }
            .navigationTitle("Order")
            .listStyle(InsetGroupedListStyle())
            .toolbar(content: {
                if !userSession.orderItems.isEmpty{
                    EditButton()
                }
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(UserSession())
    }
}
