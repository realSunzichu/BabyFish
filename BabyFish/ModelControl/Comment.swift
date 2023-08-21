//
//  Comment.swift
//  BabyFish
//
//  Created by 孙子楚 on 2023/8/9.
//
import Foundation
import SwiftUI

class Comment: Identifiable, ObservableObject {
    let id = UUID()
    let username: String
    let date: Date
    @Published var content: String
    
    init(username: String, content: String) {
        self.username = username
        self.content = content
        self.date = Date()
    }
}

