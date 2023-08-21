//
//  MainView.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/9.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var userManager = UserManager.shared
    @State private var searchText = ""
    @State private var showingCreatePostView = false
    @State var posts: [Post] = []  // 注意，我在这里为posts添加了一个默认值，这样我们就可以进行初始加载了
    
    var body: some View {
        if userManager.isLoggedin {
            ZStack(alignment: .bottomTrailing) {
                NavigationView {
                    List {
                        ForEach(posts) { post in
                            NavigationLink(destination: PostDetailView(post: post)) {
                                Text(post.content)  // 你可能需要更复杂的帖子渲染逻辑，这里仅为示范
                            }
                        }
                    }
                    .searchable(text: $searchText)
                    .refreshable {
                        await loadPosts()
                    }
                }
                
                Button(action: { showingCreatePostView = true }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                }
                .padding(.trailing, 20)
                .sheet(isPresented: $showingCreatePostView) {
                    CreatePostView(showing: $showingCreatePostView, posts: $posts)
                }
            }
        } else {
            LoginView()
        }
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
