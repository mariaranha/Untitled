//
//  Life.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 17/10/20.
//

import Foundation

enum LifeType{
    case city
    case character
}

class Life {
    
    var type: LifeType
    var value: Int
    
    //MARK: Initialization
    
    init(type: LifeType) {
        self.type = type
        
        if type == LifeType.city {
            value = 10
        } else {
            value = 10
        }
        
    }
    
    init(type: LifeType, lifeValue: Int) {
        self.value = lifeValue
        self.type = type
    }
    
    //MARK: Actions
    
    func decreaseLife(value: Int){
        self.value = self.value - value
    }
    
    func updateValue(value: Int, type: LifeType){
        self.value += value
        if self.value < 0 {
            self.value = 0
        }
        if type == .character {
            if self.value > 10 {
                self.value = 10
            }
        } else if type == .city {
            if self.value > 15 {
                self.value = 15
            }
        }
    }
    
}
