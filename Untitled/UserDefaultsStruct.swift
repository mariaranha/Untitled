//
//  UserDefaults.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 18/10/20.
//

import Foundation

struct UserDefaultsStruct {
    
    private static let defaults = UserDefaults.standard
    static var rewards : [Rewards: Bool] = [:]
    
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
    
    enum Rewards: String, CaseIterable {
        case photoChapter1
        case photoChapter2
        
        func gotReward() {
            defaults.set(true, forKey: self.rawValue)
            UserDefaultsStruct.rewards[self] = true
        }
        
        static func getRewards() {
            for i in self.allCases {
                let value = defaults.bool(forKey: i.rawValue)
                
                UserDefaultsStruct.rewards[i] = value
            }
        }
    }
}
