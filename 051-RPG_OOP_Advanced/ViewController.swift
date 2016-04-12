//
//  ViewController.swift
//  051-RPG_OOP_Advanced
//
//  Created by Meagan McDonald on 4/11/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var backgroundMusicPlayer = AVAudioPlayer()
    var soundFX: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNewGame()
    }

    @IBAction func onPlayer1Attack(sender: AnyObject) {
        if playerTwo.isAttacked(playerOne.attackPwr) {
            successAttack(playerOne, defender: playerTwo)
            btnPlayer2Attack.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enablePlayer2AttackBtn", userInfo: nil, repeats: false)
            if !playerTwo.isAlive {
                playSoundEffect("player2death.wav")
            }
        } else {
            failedAttack(playerTwo)
        }
    }
    
    @IBAction func onPlayer2Attack(sender: AnyObject) {
        if playerOne.isAttacked(playerTwo.attackPwr) {
            successAttack(playerTwo, defender: playerOne)
            btnPlayer1Attack.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enablePlayer1AttackBtn", userInfo: nil, repeats: false)
            if !playerOne.isAlive {
                playSoundEffect("player1death.wav")
            }
        } else {
            failedAttack(playerOne)
        }
    }

    @IBAction func onRestartTap(sender: AnyObject) {
        setUpNewGame()
    }
    
    func successAttack(attacker: Character, defender: Character){
        
        if defender.isAlive {
            lblGameText.text = ("\(attacker.name) attacks!\n\(defender.name)'s HP has decreased by \(attacker.lastAttack).")
        } else {
            lblGameText.text = ("\(attacker.name) has won!")
            setRestartBtn(false)
        }
        playSoundEffect("sword.wav")
    }
    
    func failedAttack(defender: Character){
        lblGameText.text = ("\(defender.name) dodges the attack!!")
        playSoundEffect("miss.wav")
    }
    
    func setUpNewGame() {
        playerOne = Orc(name: "Grug", hp: 100, attack: 15)
        playerTwo = Soldier(name: "Caesar", hp: 125, attack: 10)
        setRestartBtn(true)
        lblGameText.text = "Fight!"
        playBackgroundMusic("battle.wav")
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
    
    func playSoundEffect(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            soundFX = try AVAudioPlayer(contentsOfURL: newURL)
            if soundFX.playing {
                soundFX.stop()
            }
            soundFX.prepareToPlay()
            soundFX.play()
        } catch let error as NSError {
            print(error.description)
        }

    }
    
    func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

}

