//
//  Character.swift
//  051-RPG_OOP_Advanced
//
//  Created by Meagan McDonald on 4/11/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import Foundation

class Character {
    
    private var _name: String!
    private var _hp: Int!
    private var _attackPwr: Int!
    
    var lastAttack: Int = 0
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var attackPwr: Int {
        get {
            return _attackPwr
        }
    }
    
    var isAlive: Bool {
        get {
            if hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    init(name: String, hp: Int, attack: Int) {
        self._name = name
        self._hp = hp
        self._attackPwr = attack
    }
    
    func isAttacked(attackPwr: Int) -> Bool {
        print("\(self.name) had \(self.hp) HP")
        self._hp = self._hp - attackPwr
        print("\(self.name) now has \(self.hp) HP")
        return true
    }
    
    
    
}
