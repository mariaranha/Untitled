//
//  Auxiliary.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 14/10/20.
//

import Foundation
import UIKit

enum AppColor {
    case darkBackground
    case lightBackground
    case intermediateBackground
    case darkGreyBackground
    
    case darkText
    case lightText
    case intermediateLightText
    case intermediateDarkText
    case highlightText
    
    case darkBorder
    case lightBorder
    case intermediateBorder
}

extension AppColor {
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .darkBackground:
            instanceColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.1568627451, alpha: 1)
        case .lightBackground:
            instanceColor = #colorLiteral(red: 0.9176470588, green: 0.862745098, blue: 0.8431372549, alpha: 1)
        case .intermediateBackground:
            instanceColor = #colorLiteral(red: 0.3058823529, green: 0.1960784314, blue: 0.6588235294, alpha: 1)
        case .darkGreyBackground:
            instanceColor = #colorLiteral(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00)
            
        case .darkText:
            instanceColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.1568627451, alpha: 1)
        case .lightText:
            instanceColor = #colorLiteral(red: 0.9607843137, green: 0.9098039216, blue: 0.8392156863, alpha: 1)
        case .intermediateLightText:
            instanceColor = #colorLiteral(red: 0.3058823529, green: 0.1960784314, blue: 0.6588235294, alpha: 1)
        case .intermediateDarkText:
            instanceColor = #colorLiteral(red: 0.4274509804, green: 0.3568627451, blue: 0.3568627451, alpha: 1)
        case .highlightText:
            instanceColor = #colorLiteral(red: 0.9882352941, green: 0.7921568627, blue: 0.431372549, alpha: 1)
            
        case .darkBorder:
            instanceColor = #colorLiteral(red: 0.4274509804, green: 0.3568627451, blue: 0.3568627451, alpha: 1)
        case .lightBorder:
            instanceColor = #colorLiteral(red: 0.9607843137, green: 0.9098039216, blue: 0.8392156863, alpha: 1)
        case .intermediateBorder:
            instanceColor = #colorLiteral(red: 0.3058823529, green: 0.1960784314, blue: 0.6588235294, alpha: 1)
        }
        
        return instanceColor
    }
}
