//
//  Users.swift
//  iDine
//
//  Created by Noe Duran on 5/25/21.
//

import SwiftUI


enum AppTabs: Hashable {
    case menu
    case favorites
    case order
    case profile
    case debug
}

class UserSession: ObservableObject {
    @Published var currentTab:      AppTabs?
    @Published var mostRecentOrder: MenuItem?

    @Published var shouldMenuDetailedActive: Bool   = false
    @Published var shouldOrderDetailedActive: Bool  = false
    @Published var showOrderAdded: Bool             = false
    @Published var isUserLoggedIn: Bool             = false
    @Published var isCreateMembershipVisible: Bool  = false
    
    @Published var isMenuActive: Bool = false
    @Published var isOrderActive: Bool = false
    
    @Published var userList = [MemberInfo]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(userList) {
                UserDefaults.standard.set(encoded, forKey: "userList")
            }
        }
    }
    @Published var user: MemberInfo? {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(user) {
                UserDefaults.standard.set(encoded, forKey: "user")
            }
        }
    }
    @Published var orderItems = [MenuItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(orderItems) {
                UserDefaults.standard.set(encoded, forKey: "orderItems")
            }
        }
    }
    
    init() {
        if let orderItems = UserDefaults.standard.data(forKey: "orderItems") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([MenuItem].self, from: orderItems) {
                self.orderItems = decoded
            } else {
                self.orderItems = []
            }
        }
        if let userList = UserDefaults.standard.data(forKey: "userList") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([MemberInfo].self, from: userList) {
                self.userList = decoded
            } else {
                self.userList = []
            }
        }
        
        getUser()
    }
    
    func getUser() {
        if let user = UserDefaults.standard.data(forKey: "user") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(MemberInfo.self, from: user) {
                self.user = decoded
                self.isUserLoggedIn = true
            } else {
                self.user = nil
            }
        }
    }
    
    func addFavorite(item: MenuItem){
        if var user = user {
            user.favorites.append(item)
            self.user = user
        }
    }
    
    func isFavorited(item: MenuItem) -> Bool {
        if let user = user {
            return user.favorites.contains(item)
        }
        return false
    }
    
    func removeFavorite(item: MenuItem){
        if let itemIndex = user?.favorites.firstIndex(of: item), var user = user{
            user.favorites.remove(at: itemIndex)
            self.user = user
        }
    }

    func removeFavorite(at index: IndexSet){
        if var user = user {
            user.favorites.remove(atOffsets: index)
            self.user = user
        }
    }
    
    func getUserFavorites() -> [MenuItem] {
        if let user = user {
            return user.favorites
        }
        return []
    }
    
    var orderTotal: Int {
        if orderItems.count > 0 {
            return orderItems.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }

    func addOrder(item: MenuItem) {
        orderItems.append(item)
        mostRecentOrder = item

        withAnimation {
            showOrderAdded = true
        }
    }

    func removeOrder(item: MenuItem) {
        if let index = orderItems.firstIndex(of: item) {
            orderItems.remove(at: index)
        }
    }
    
    func logInUser(user: MemberInfo) {
        self.user = self.getUser(user: user)
        print(user.favorites)
        isUserLoggedIn = true
        isCreateMembershipVisible = false
    }
    
    func signOutUser() {
        user = nil
        isUserLoggedIn = false
    }
    
    func addUser(user: MemberInfo) {
        userList.append(user)
    }
    
    func signUpUser(_ newUser: MemberInfo){
        userList.append(newUser)
        self.user = newUser
        isUserLoggedIn = true
        isCreateMembershipVisible = false
    }
    
    func removeUser() {
        if let user = user, let index = userList.firstIndex(of: user){
                userList.remove(at: index)
                isUserLoggedIn = false
        }
    }
    
    func findUsername(user: String) -> Bool {
        if userList.first(where: { $0.email == user }) != nil {
            return true
        }
        return false
    }
    
    func getUser(user: MemberInfo) -> MemberInfo? {
        if let foundUser = userList.first(where: { $0.email == user.email }) {
            if user.password == foundUser.password {
                return foundUser
            }
        }
        return nil
    }
}


