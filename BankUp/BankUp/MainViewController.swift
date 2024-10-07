//
//  MainViewController.swift
//  BankUp
//
//  Created by Oguz Mert Beyoglu on 7.10.2024.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        let summaryVC   = AccountSummaryViewController()
        let moneyVC     = MoveMoneyViewController()
        let moreVC      = MoreViewController()
        
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.2.circlepath.circle.fill", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle.fill", title: "More")
        
        let summaryNC   = UINavigationController(rootViewController: summaryVC)
        let moneyNC     = UINavigationController(rootViewController: moneyVC)
        let moreNC      = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moneyNC, moreNC]
        
        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage   = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor        = appColor
        tabBar.isTranslucent    = false
        
    }
}

class AccountSummaryViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemYellow
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBlue
    }
}
 
