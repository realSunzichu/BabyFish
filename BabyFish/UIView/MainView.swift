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
    @State var posts: [Post] = []
    
    // 分页相关属性
    @State private var currentPage = 0
    private let postsPerPage = 15
    
    var body: some View {
        if userManager.isLoggedin {
            ZStack(alignment: .bottomTrailing) {
                NavigationView {
                    ScrollView {
                        LazyVStack {
                            ForEach(posts) { post in
                                NavigationLink(destination: PostDetailView(post: post)) {
                                    Text(post.content)
                                }
                            }
                            GeometryReader { geometry in
                                Color.clear.preference(key: ViewOffsetKey.self, value: geometry.frame(in: .global).minY)
                            }
                        }
                        .onPreferenceChange(ViewOffsetKey.self) { minY in
                            let threshold: CGFloat = -50  // 添加阈值
                            if minY > threshold {
                                Task {
                                    await loadPosts()
                                }
                            }
                        }
                    }
                    .searchable(text: $searchText)
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
        // 增加当前页数
        currentPage += 1
        
        // TODO: 在这里放置实际的网络请求代码
        
    }
}

// GeometryReader 用来检测滚动位置
private struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
