//
//  RankingViewController.swift
//  BarabaraGame
//
//  Created by 工藤彩名 on 2022/05/10.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet var rankingLabel1: UILabel!
    @IBOutlet var rankingLabel2: UILabel!
    @IBOutlet var rankingLabel3: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        rankingLabel1.text = String(defaults.integer(forKey: "score1"))
        rankingLabel2.text = String(defaults.integer(forKey: "score2"))
        rankingLabel3.text = String(defaults.integer(forKey: "score3"))
    }
    

    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }

}
