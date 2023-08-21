//
//  LoginView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/7.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var userManager = UserManager.shared
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("BFish")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(.top, 2)
                Spacer().frame(height: 30)
                VStack(alignment: .leading, spacing: 20) {
                    Text("账号")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    TextField("", text: $viewModel.username)
                        .font(.system(size: 22))
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color(.black)),
                            alignment: .bottom
                        )
                    
                    Text("密码")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    SecureField("", text: $viewModel.password)
                        .font(.system(size: 22))
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color(.black)),
                            alignment: .bottom
                        )
                }
                Spacer().frame(height: 30)
                Button(action: {
                    viewModel.login() { success in
                        if success {
                            userManager.login()
                        }
                    }
                }) {
                    Text("登入")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.black)
                        .cornerRadius(40.0)
                }

                if viewModel.isLoggedIn == true {
                    NavigationLink(destination: MainView()) {
                        EmptyView()
                    }
                }
                
                NavigationLink(destination: RegisterView()) {
                    Text("还没有账号? 点击注册")
                        .foregroundColor(.black)
                }
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
