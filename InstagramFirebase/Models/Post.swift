//
//  Post.swift
//  InstagramFirebase
//
//  Created by Mohammed Hamdi on 3/24/20.
//  Copyright © 2020 Mohammed Hamdi. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
