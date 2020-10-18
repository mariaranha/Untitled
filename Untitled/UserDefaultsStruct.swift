//
//  UserDefaults.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 18/10/20.
//

import Foundation

struct UserDefaultsStruct {
    
    private static let defaults = UserDefaults.standard
    
    struct UserLevel {
        static var level: Int {
            get {
                guard defaults.integer(forKey: "userLevel") != 0 else { return 1 }
                return defaults.integer(forKey: "userLevel")
            }
            set {
                defaults.set(newValue, forKey: "userLevel")
                defaults.synchronize()
            }
        }
    }
    
}

