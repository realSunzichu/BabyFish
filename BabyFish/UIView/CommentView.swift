//
//  CommentView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/9.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var comment: Comment
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: comment.date)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(comment.username)
                    .font(.headline)
                Spacer()
                Text(formattedDate)  // Display the formatted date
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Text(comment.content)
        }
        .padding(.top)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(username: "用户1", content: "这是预览评论的内容..."))
    }
}
