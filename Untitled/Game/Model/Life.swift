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
    private var lifeValue: Float
    
    //MARK: Initialization
    
    init(type: LifeType) {
        self.type = type
        
        if type == LifeType.city{
            lifeValue = 0.0
        } else{
            lifeValue = 5.0
        }
        
    }
    
    init(type: LifeType, lifeValue: Float) {
        self.lifeValue = lifeValue
        self.type = type
    }
    
    //MARK: Actions
    
    func decreaseLife(value: Float){
        self.lifeValue = self.lifeValue - value
    }
    
    func updateLife(value: Float){
        self.lifeValue = value
    }
    
}
