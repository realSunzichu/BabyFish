//
//  CommunityView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/7.
//

import SwiftUI

struct CommunityView: View {
    @Binding var posts: [Post]

    var body: some View {
        List(posts) { post in
            PostView(post: post)
        }
        .refreshable {
            await loadPosts()
        }
        .navigationTitle("社区")
    }

    func loadPosts() async {
        // 暂停一秒以模拟网络请求延迟
        await Task.sleep(1 * 1_000_000_000)
        
        // TODO: 在这里放置实际的网络请求代码
        
        // 以下是模拟数据
        posts = [
            // 示例数据
            Post(username: "用户1", avatar: "avatar1", content: "这是一个新的示例帖子", comments: []),
            // ... 可以添加更多模拟帖子
        ]
    }
}

struct PostView: View {
    var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(post.avatar)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(post.username)
                Spacer()
            }
            
            // 将 NavigationLink 仅用于帖子内容
            NavigationLink(destination: PostDetailView(post: post)) {
                Text(post.content.prefix(100) + "")  // 显示内容摘要
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    @State static var posts = [Post]()

    static var previews: some View {
        CommunityView(posts: $posts)
    }
}
