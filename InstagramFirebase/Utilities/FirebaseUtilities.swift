//
//  FirebaseUtilities.swift
//  InstagramFirebase
//
//  Created by Mohammed Hamdi on 3/26/20.
//  Copyright © 2020 Mohammed Hamdi. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dictionary: userDictionary)
            completion(user)
            
        }) { (error) in
            print("Failed to fetch user: ", error)
        }
    }
}
