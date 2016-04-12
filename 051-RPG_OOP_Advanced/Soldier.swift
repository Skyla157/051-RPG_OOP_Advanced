//
//  Soldier.swift
//  051-RPG_OOP_Advanced
//
//  Created by Meagan McDonald on 4/11/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import Foundation

class Soldier: Character {
    
    let IMMUNE_MAX = 10
    
    override var attackPwr: Int {
        return Int(arc4random_uniform(20) + 10)
    }
    
    override func attacked(attackPwr: Int) -> Bool {
        if (attackPwr > IMMUNE_MAX) {
            return super.attacked(attackPwr)
        } else {
            return false
        }
    }
}