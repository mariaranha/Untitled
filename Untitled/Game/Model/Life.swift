//
//  Life.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 17/10/20.
//

import Foundation

class Life {
    
    private var lifeValue: Float
    
    //MARK: Initialization
     
    init() {
        self.lifeValue = 5.0
    }
    
    init(lifeValue: Float) {
        self.lifeValue = lifeValue
    }
    
    //MARK: Actions
    
    func decreaseLife(value: Float){
        self.lifeValue = self.lifeValue - value
    }
    
    func updateLife(value: Float){
        self.lifeValue = value
    }
    
}
