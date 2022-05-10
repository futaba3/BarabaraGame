//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by 工藤彩名 on 2022/05/10.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView!
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    
    @IBOutlet var resultLabel: UILabel!
    
    // 画像を動かすためのタイマー
    var timer: Timer!
    // 元になるスコアの値
    var score: Int = 1000
    // ストップした後のスコアの値（scoreのままだとstopを押すたびに値が変わってしまう）
    var newScore: Int = 0
    
    let defaults: UserDefaults = UserDefaults.standard
    // 画面の幅
    let width: CGFloat = UIScreen.main.bounds.size.width
    // 画像の位置の配列
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
    // 画像の動かす幅の配列
    var dx: [CGFloat] = [1.0, 0.5, -1.0]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        positionX = [width/2, width/2, width/2]
        self.start()
    }
    
    func start() {
        resultLabel.isHidden = true
        // タイマーを動かす selectorはタイマーが呼び出すメソッド
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func up() {
        for i in 0..<3 {
            // 端にきたら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            // 画像の位置をdx分ずらす
            positionX[i] += dx[i]
        }
        imgView1.center.x = positionX[0]
        imgView2.center.x = positionX[1]
        imgView3.center.x = positionX[2]
    }
    
    @IBAction func stop() {
        // タイマーが動いていたら
        if timer.isValid == true {
            // タイマーを止める（無効）
            timer.invalidate()
        }
        
        for i in 0..<3 {
            // absは真ん中からどれだけずれているかを計算 ずれた分だけスコアを減らす
            newScore = score - abs(Int(width/2 - positionX[i]))*2
        }
        resultLabel.text = "Score：" + String(newScore)
        resultLabel.isHidden = false
        
        //　highScoreの値を取り出す
        let highScore1: Int = defaults.integer(forKey: "score1")
        let highScore2: Int = defaults.integer(forKey: "score2")
        let highScore3: Int = defaults.integer(forKey: "score3")

        if newScore > highScore1 {
            defaults.set(newScore, forKey: "score1")
            defaults.set(highScore1, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
            
        } else if newScore > highScore2 {
            defaults.set(newScore, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
            
        } else if newScore > highScore3 {
            defaults.set(newScore, forKey: "score3")
        }
        defaults.synchronize()
    }
    
    @IBAction func retry() {
        score = 1000
        positionX = [width/2, width/2, width/2]
        if timer.isValid == false {
            self.start()
        }
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }

    
}
