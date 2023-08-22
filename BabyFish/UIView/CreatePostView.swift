//
//  CreatePostView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/9.
//

import SwiftUI

struct CreatePostView: View {
    @Binding var showing: Bool
    @Binding var posts: [Post]
    @State private var postContent = ""

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $postContent)
                    .border(Color.gray, width: 1)
                Button(action: {
                    submitPost()
                    showing = false
                }) {
                    Text("提交")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                }
                .padding(.horizontal)
            }
            .navigationTitle("新的帖文")
            .navigationBarItems(leading: Button("取消") { showing = false })
        }
    }

    func submitPost() {
        let trimmedContent = postContent.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedContent.isEmpty else {
            return
        }
        
        let newPost = Post(username: "新用户", avatar: nil, content: trimmedContent, comments: [])
        posts.append(newPost)
    }
}
