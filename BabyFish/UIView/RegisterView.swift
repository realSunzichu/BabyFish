//
//  RegisterView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/13.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var verificationCode: String = ""
    @State private var actualVerificationCode: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // For Avatar Upload
    @State private var showingImagePicker = false
    @State private var avatarImage: UIImage?

    var body: some View {
        VStack(spacing: 15) {
            if let image = avatarImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle")  // default avatar
                    .resizable()
                    .frame(width: 100, height: 100)
            }

            Button("选择头像") {
                showingImagePicker.toggle()
            }
            .padding(.bottom, 20)

            TextField("用户名", text: $username)
                .padding()
                .border(Color.black, width: 0.5)

            TextField("邮箱", text: $email)
                .padding()
                .border(Color.black, width: 0.5)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("密码", text: $password)
                .padding()
                .border(Color.black, width: 0.5)

            TextField("验证码", text: $verificationCode)
                .padding()
                .border(Color.black, width: 0.5)
                .keyboardType(.numberPad)

            Button("发送验证码") {
                self.sendVerificationCode()
            }
            .padding()

            Button("注册") {
                validateAndRegister()
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("错误"), message: Text(alertMessage), dismissButton: .default(Text("知道了")))
            }
        }
        .padding()
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(isPresented: $showingImagePicker, selectedImage: $avatarImage)
        }
    }
    

    func sendVerificationCode() {
        self.actualVerificationCode = String(format: "%04d", Int.random(in: 1000..<10000))
        print("验证码为: \(self.actualVerificationCode)")  // 在真实环境中，应该删除此行
    }

    func validateAndRegister() {
        if !isValidUsername(self.username) {
            self.alertMessage = "用户名应包含汉字或字母，且不超过8个字符。"
            self.showingAlert = true
            return
        }
        if !isValidEmail(self.email) {
            self.alertMessage = "邮箱必须以@stu.blcu.edu.cn结尾。"
            self.showingAlert = true
            return
        }
        if !isValidPassword(self.password) {
            self.alertMessage = "密码需要至少8个字符，并包含至少一个大写字母、一个小写字母和一个数字。"
            self.showingAlert = true
            return
        }
        if self.verificationCode != self.actualVerificationCode {
            self.alertMessage = "验证码不正确。"
            self.showingAlert = true
            return
        }

        // 如果所有验证都通过，继续进行注册逻辑
    }

    func isValidUsername(_ username: String) -> Bool {
        let regex = "^[\\u4e00-\\u9fa5a-zA-Z]{1,8}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: username)
    }

    func isValidEmail(_ email: String) -> Bool {
        let regex = "^[a-zA-Z0-9._%+-]+@stu\\.blcu\\.edu\\.cn$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
