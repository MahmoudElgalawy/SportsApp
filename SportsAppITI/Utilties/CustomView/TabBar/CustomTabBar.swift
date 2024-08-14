//
//  CustomTabBar.swift
//  SportsAppITI
//
//  Created by Engy on 8/14/24.
//

import UIKit

class CustomTabBarController: UITabBarController {

    private let leftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "figure.american.football"), for: .normal) // Use appropriate system image
        button.setTitle("SPORTS", for: .normal)
        button.tintColor = .gray
        button.layer.cornerRadius = 25
        return button
    }()

    private let rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Favorties", for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal) 
        button.tintColor = .gray
        button.layer.cornerRadius = 25
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    func setupTabBar() {
        // Add the left and right buttons to the tab bar
        self.tabBar.addSubview(leftButton)
        self.tabBar.addSubview(rightButton)

        let buttonSize: CGFloat = 50
        let yOffset: CGFloat = 10

        let xOffsetLeft = 60.0 // Position from the left side
        leftButton.frame = CGRect(x: xOffsetLeft, y: yOffset, width: buttonSize, height: buttonSize)

        // Set up the right button frame
        let xOffsetRight = self.tabBar.bounds.width - buttonSize - 20.0 // Position from the right side
        rightButton.frame = CGRect(x: xOffsetRight, y: yOffset, width: buttonSize, height: buttonSize)

        // Handle button taps
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }

    @objc func leftButtonTapped() {
        print("Left button tapped")
    }

    @objc func rightButtonTapped() {
        print("Right button tapped")
    }
}
