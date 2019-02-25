//
//  Authenticate.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import Foundation
import FirebaseAuth

class Authenticate {
    static let instance = Authenticate()
    
    func loginUser(email : String, password : String, completion : @escaping ( _ status : Bool, _ e : Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, e) in
            if e == nil {
                // Set user online status as online
                // Return true
                DataBase.instance.getUserDisplayName(uid: Authenticate.instance.getCurrentUserID()) {
                    (name) in
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.name = name
                    delegate.isAuthenticated = true
                }
                completion(true, nil)
                return
            }
            else {
                completion(false, nil)
                return
            }
        }
    }
    
    func signupUser(displayName : String , email : String, password : String, completion : @escaping ( _ status : Bool , _ e : Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (user, e) in
            guard user == user else {
                completion(false, nil)
                return
            }
            
            // Add metadata to database
            let metadata = ["displayName" : displayName, "email" : email]
            DataBase.instance.createUsers(uid: Authenticate.instance.getCurrentUserID(), metadata: metadata)
            
            DataBase.instance.getUserDisplayName(uid: Authenticate.instance.getCurrentUserID()) {
                (name) in
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.name = name
                delegate.email = email
                delegate.isAuthenticated = true
            }
            completion(true, nil)
        }
    }
    
    func getCurrentUserID() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Unable to log out user")
        }
    }

}



