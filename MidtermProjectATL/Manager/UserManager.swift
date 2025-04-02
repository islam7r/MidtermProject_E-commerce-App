//
//  UserManager.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 01.04.25.
//

import UIKit

class UserManager {
    static let shared = UserManager()
    
    var users: [UserInfoModel] = []
    
    func setUser(_ user: UserInfoModel) {
        users.append(user)
    }
    
    func removeUser() {
        users.removeAll()
    }
    
    func getUser() -> [UserInfoModel] {
        return users
    }
    
}


