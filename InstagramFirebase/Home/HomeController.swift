//
//  HomeController.swift
//  InstagramFirebase
//
//  Created by Mohammed Hamdi on 3/25/20.
//  Copyright © 2020 Mohammed Hamdi. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    var posts = [Post]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        fetchPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 40 + 8 + 8 //username + userprofileImageView
        height += view.frame.width
        height += 50
        height += 60
        
        return .init(width: view.frame.width, height: height)
    }
    
    func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    fileprivate func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPostsWithUser(user: user)
        }
//        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//
//            guard let userDictionary = snapshot.value as? [String: Any] else { return }
//
//            let user = User(dictionary: userDictionary)
//
//            let ref = Database.database().reference().child("posts").child(uid)
//
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                guard let dictionaries = snapshot.value as? [String: Any] else { return }
//
//                dictionaries.forEach { (key, value) in
//                    guard let dictionary = value as? [String: Any] else { return }
//
//                    let post = Post(user: user, dictionary: dictionary)
//                    self.posts.append(post)
//                }
//
//                self.collectionView.reloadData()
//            }) { (error) in
//                print("Failed to fetch posts: ", error)
//            }
//        }) { (error) in
//            print("Failed to fetch user for posts: ", error)
//        }
    }
    
    fileprivate func fetchPostsWithUser(user: User) {
        let ref = Database.database().reference().child("posts").child(user.uid)

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }

            dictionaries.forEach { (key, value) in
                guard let dictionary = value as? [String: Any] else { return }

                let post = Post(user: user, dictionary: dictionary)
                self.posts.append(post)
            }

            self.collectionView.reloadData()
        }) { (error) in
            print("Failed to fetch posts: ", error)
        }
    }
}
