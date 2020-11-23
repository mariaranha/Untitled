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
    static var chapterTitle: String = ""
    static var chapterSubtitle: String = ""
    static let numChapters: Int = 3
}
