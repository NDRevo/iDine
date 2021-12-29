//
//  CheckoutView.swift
//  iDine
//
//  Created by Noe Duran on 4/21/21.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var userSession: UserSession
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let tipAmounts = [10, 15, 20, 25, 0]
    let times = ["ASAP","Tonight","Tomorrow"]
    
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showPaymentAlert = false
    @State private var time = "ASAP"
    
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(userSession.orderTotal)
        let tipValue = Double(tipAmount) / 100 * total
        
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
    }
    
    var body: some View {
        Form{
            Section{
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self){
                        Text($0)
                    }
                }
                
                if !userSession.isUserLoggedIn {
                    Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                    
                    if addLoyaltyDetails {
                        TextField("Enter your iDine loyalty number", text: $loyaltyNumber)
                    }
                }
            }
            Section(header: Text("Pickup Time")){
                Picker("Pickup Time", selection: $time){
                    ForEach(times, id: \.self){
                        Text($0)
                    }
                }
            }
            Section(header: Text("Add a tip?")){
                Picker("Percentage:", selection: $tipAmount){
                    ForEach(tipAmounts, id: \.self){
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            }
            Section(header: Text("Total: \(totalPrice)").font(.largeTitle)){
                Button("Confirm Order"){
                    showPaymentAlert.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showPaymentAlert) {
            Alert(
                title: Text("Order confirmed"),
                message: Text("Your total is \(totalPrice) - Thank you!"),
                dismissButton: .default(Text("Ok"), action: {
                    userSession.isMenuActive = false
                    userSession.isOrderActive = false
                    userSession.orderItems = []
                    
            })
            )
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(UserSession())
    }
}
