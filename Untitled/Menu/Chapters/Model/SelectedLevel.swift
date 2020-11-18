//
//  SelectedLevel.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 18/11/20.
//

import Foundation

struct SelectedLevel {
    static var level = UserDefaultsStruct.UserLevel.level
    static var numNarrativePages: Int = 0
    
    func setLevelValues() {
        let level = SelectedLevel.level
        
        switch level {
        case 1:
            SelectedLevel.numNarrativePages = 6
        case 2:
            SelectedLevel.numNarrativePages = 5
        case 3:
            SelectedLevel.numNarrativePages = 6
        default:
            break
        }
    }
}
