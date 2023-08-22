//
//  AddCommentView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/22.
//

import SwiftUI

struct AddCommentView: View {
    @Binding var comments: [Comment]
    @State private var newCommentContent: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("添加评论")
                .font(.title)
            
            TextEditor(text: $newCommentContent)
                .padding()
                .border(Color.gray, width: 1)
                .frame(height: 200)
            
            Button("提交评论") {
                let trimmedContent = newCommentContent.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmedContent.isEmpty else {
                    // 可以在这里添加一个警告或提示用户评论不能为空
                    return
                }
                let newComment = Comment(username: "当前用户名", content: newCommentContent)
                comments.append(newComment)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}
