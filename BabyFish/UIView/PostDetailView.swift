//
//  PostDetailView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/9.
//
import SwiftUI

class Post: Identifiable, ObservableObject {
    let id = UUID()
    let date: Date
    let username: String
    @Published var avatar: UIImage?
    @Published var content: String
    @Published var comments: [Comment]

    init(username: String, avatar: UIImage?, content: String, comments: [Comment]) {
        self.date = Date()
        self.username = username
        self.avatar = avatar
        self.content = content
        self.comments = comments
    }
}

struct PostDetailView: View {
    @ObservedObject var post: Post
    @State private var showingAddComment = false

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: post.date)
    }

    var body: some View {
        ScrollView {
            VStack {
                // 显示头像，用户名，帖子内容
                HStack {
                    // Handling the optional UIImage
                    if let avatarImage = post.avatar {
                        Image(uiImage: avatarImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())  // 圆形头像
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Text(post.username)
                    Spacer()
                }

                Text(post.content)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Text(formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack {
                    // 显示评论数
                    Image(systemName: "ellipsis.bubble")
                    Text("\(post.comments.count)")
                }
                .padding(.top)

                Divider()
                    .padding(.vertical)

                Text("评论")
                    .font(.headline)
                    .padding(.bottom)

                ForEach(post.comments) { comment in
                    CommentView(comment: comment)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Divider()  // 在每个评论之间添加一个分割线
                }

                Button(action: {
                    showingAddComment.toggle()
                }) {
                    Text("添加评论")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showingAddComment) {
                    AddCommentView(comments: $post.comments)
                }
                .padding(.top)
            }
            .padding()
        }
    }
}
