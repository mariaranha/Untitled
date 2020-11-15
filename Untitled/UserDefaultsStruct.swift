//
//  UserDefaults.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 18/10/20.
//

import Foundation

enum Languages: String {
    case english = "en"
    case portuguese = "pt-BR"
    case portugueseDevice = "pt"
}

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
    
    struct IntroNarrative {
        static var skipeIntro: Bool {
            get {
                return defaults.bool(forKey: "introNarrative")
            }
            set {
                defaults.set(newValue, forKey: "introNarrative")
                defaults.synchronize()
            }
        }
    }
    
    struct Language {
        static var preferLanguage: String {
            get {
                return defaults.string(forKey: "preferLanguage") ?? ""
            }
            set {
                defaults.set(newValue, forKey: "preferLanguage")
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
    
    struct Tutorial {
        static var skipChapterOne: Bool {
            get {
                return defaults.bool(forKey: "tutorialOne")
            }
            set {
                defaults.set(newValue, forKey: "tutorialOne")
                defaults.synchronize()
            }
        }
        
        static var skipChapterTwo: Bool {
            get {
                return defaults.bool(forKey: "tutorialTwo")
            }
            set {
                defaults.set(newValue, forKey: "tutorialTwo")
                defaults.synchronize()
            }
        }
        
        static var skipChapterThree: Bool {
            get {
                return defaults.bool(forKey: "tutorialThree")
            }
            set {
                defaults.set(newValue, forKey: "tutorialThree")
                defaults.synchronize()
            }
        }
    }
}
