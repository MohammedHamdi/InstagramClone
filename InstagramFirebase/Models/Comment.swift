//
//  Comment.swift
//  InstagramFirebase
//
//  Created by Mohammed Hamdi on 3/29/20.
//  Copyright © 2020 Mohammed Hamdi. All rights reserved.
//

import Foundation

struct Comment {
    
    let user: User
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
