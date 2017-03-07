//
//  FireBase.swift
//  Bacon
//
//  Created by Pantheb Tachajarrupan on 2/2/2560 BE.
//  Copyright © 2560 Toyota Leasing Thailand. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }

    
}

