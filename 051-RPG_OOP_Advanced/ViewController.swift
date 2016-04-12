//
//  ViewController.swift
//  051-RPG_OOP_Advanced
//
//  Created by Meagan McDonald on 4/11/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var lblGameText: UILabel!
    @IBOutlet weak var btnPlayer1Attack: UIButton!
    @IBOutlet weak var btnPlayer2Attack: UIButton!
    @IBOutlet weak var btnRestart: UIButton!
    @IBOutlet weak var txtRestart: UILabel!
    
    var playerOne = Orc!()
    var playerTwo = Soldier!()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNewGame()
    }


    @IBAction func onPlayer1Attack(sender: AnyObject) {
        if playerTwo.attacked(playerOne.attackPwr) {
            isPlayerAlive(playerOne, defender: playerTwo)
            btnPlayer2Attack.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enablePlayer2AttackBtn", userInfo: nil, repeats: false)
        } else {
            failedAttack(playerTwo)
        }
    }
    
    @IBAction func onPlayer2Attack(sender: AnyObject) {
        if playerOne.attacked(playerTwo.attackPwr) {
            isPlayerAlive(playerTwo, defender: playerOne)
            btnPlayer1Attack.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enablePlayer1AttackBtn", userInfo: nil, repeats: false)
        } else {
            failedAttack(playerOne)
        }
    }

    @IBAction func onRestartTap(sender: AnyObject) {
        setUpNewGame()
    }
    
    func isPlayerAlive(attacker: Character, defender: Character){
        if defender.isAlive {
            lblGameText.text = ("\(attacker.name) attacks!\n\(defender.name)'s HP has decreased by \(attacker.attackPwr).")
            print("\(defender.name)'s HP is now \(defender.hp)")
        } else {
            lblGameText.text = ("\(attacker.name) has won!")
            setRestartBtn(false)
        }
    }
    
    func failedAttack(defender: Character){
        lblGameText.text = ("\(defender.name) dodges the attack!!")
    }
    
    func setUpNewGame() {
        
        playerOne = Orc(name: "Grug", hp: 100, attack: 15)
        playerTwo = Soldier(name: "Caesar", hp: 150, attack: 10)
        setRestartBtn(true)
        lblGameText.text = "Fight!"
    }
    
    func enablePlayer1AttackBtn(){
        btnPlayer1Attack.enabled = true
    }
    
    func enablePlayer2AttackBtn(){
        btnPlayer2Attack.enabled = true
    }
    
    func setRestartBtn(ans: Bool) {
        btnRestart.hidden = ans
        txtRestart.hidden = ans
    }

}

