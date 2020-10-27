//
//  LevelData.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 08/10/20.
//

import Foundation

class LevelData: Codable {
    let tiles: [[Int]]
    let photoPosition: [String: Int]
    let randomPercentage: [Double]
    let energyCity: Int
    let exitPosition: [[String: Int]]
    let riotPoliceValue: [Int]
    let tacticalPoliceValue: [Int]
    let blockValue: [Int]
    let photoRollValue: [Int]
    let riotPoliceValuePercentage: [Double]
    let tacticalPoliceValuePercentage: [Double]
    let blockValuePercentage: [Double]
    let photoRollValuePercentage: [Double]
    let characterPosition: [String: Int]
    
    
  static func loadFrom(file filename: String) -> LevelData? {
    var data: Data
    var levelData: LevelData?
    
    if let path = Bundle.main.url(forResource: filename, withExtension: "json") {
      do {
        data = try Data(contentsOf: path)
      }
      catch {
        print("Could not load level file: \(filename), error: \(error)")
        return nil
      }
      do {
        levelData = try JSONDecoder().decode(LevelData.self, from: data)
      }
      catch {
        print("Level file '\(filename)' is not valid JSON: \(error)")
        return nil
      }
    }
    return levelData
  }
}