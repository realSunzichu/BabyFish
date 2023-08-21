//
//  UserManager.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/13.
//

import Foundation
class UserManager: ObservableObject {
    static let shared = UserManager()
    private init() {}

    @Published var isLoggedin: Bool = UserDefaults.standard.bool(forKey: "isLoggedin")

    func login() {
        self.isLoggedin = true
        UserDefaults.standard.setValue(true, forKey: "isLoggedin")
    }

    func logout() {
        self.isLoggedin = false
        UserDefaults.standard.setValue(false, forKey: "isLoggedin")
    }
}
