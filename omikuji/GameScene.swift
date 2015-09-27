//
//  GameScene.swift
//  omikuji
//
//  Created by Yoji Hayashi on 2015/09/23.
//  Copyright (c) 2015年 Yoji Hayashi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    //イラスト用スプライトを用意する
    let omikujikun = SKSpriteNode(imageNamed: "omikuji.png")
    //ボタン用スプライトを用意する
    let btnSprite = SKSpriteNode(imageNamed: "button.png")
    //おみくじ結果用ラベルを用意する
    let result = SKLabelNode(fontNamed: "Verdana-bold")

    override func didMoveToView(view: SKView) {
        //背景色をつける
        self.backgroundColor = SKColor.whiteColor()
        //イラストを表示する
        omikujikun.position = CGPoint(x: 375, y: 900)
        self.addChild(omikujikun)
        //ボタンを表示する
        btnSprite.position = CGPoint(x: 375, y: 200)
        self.addChild(btnSprite)
        //おみくじ結果用ラベルを表示する
        result.text = "???"
        result.fontSize = 65
        result.fontColor = SKColor.blackColor()
        result.position = CGPoint(x: 375, y: 500)
        self.addChild(result)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            //タッチされた位置にあるものを調べて
            let location = touch.locationInNode(self)
            let touchNode = self.nodeAtPoint(location)
            //もしボタンなら
            if touchNode == btnSprite{
                //???と表示してから、おみくじを振る
                result.text = "???"
                shakeOmikuji()
            }
        }
    }
    
    //おみくじを振る処理
    func shakeOmikuji(){
        //【おみくじを振るアクションをつける】
        //おみくじを少し右に傾けるアクション
        let action1 = SKAction.rotateToAngle(-0.3, duration: 0.2)
        //おみくじを少し左に傾けるアクション
        let action2 = SKAction.rotateToAngle( 0.3, duration: 0.2)
        //おみくじをひっくり返すアクション
        let action3 = SKAction.rotateToAngle( 3.14, duration: 0.2)
        //action1,action2,action3を指定した順番に行う
        let actionS = SKAction.sequence([action1, action2, action1, action2, action1, action3])
        //おみくじに「左右に振ってひっくり返すアクション」をつけて、最後に結果を実行する
        omikujikun.runAction(actionS, completion: showOmikuji)
    }
    //結果を表示する処理
    func showOmikuji(){
        var omikuji = ["大吉","中吉","吉","凶"]
        var r = Int(arc4random_uniform(4))
        result.text = omikuji[r]
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
