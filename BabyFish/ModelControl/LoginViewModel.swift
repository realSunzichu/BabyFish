//
//  LoginViewModel.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/7.
//
import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool? = nil

    func login(completion: @escaping (Bool) -> Void) {
        // 这里写登录的逻辑
        // 例如，如果登录成功：
        DispatchQueue.main.async {
            self.isLoggedIn = true
            completion(true)
        }
        // 如果登录失败，可以设置：
        // self.isLoggedIn = false
    }
}
