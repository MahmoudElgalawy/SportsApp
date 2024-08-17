import UIKit

class CustomTabBarController: UITabBarController {

    private let leftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "sportscourt.fill"), for: .normal) // Use appropriate system image
        button.tintColor = .black
        button.layer.cornerRadius = 25
        return button
    }()

    private let rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "sportscourt.fill"), for: .normal) // Use appropriate system image
        button.tintColor = .black
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

        // Set up the left button frame
        let buttonSize: CGFloat = 50
        let yOffset: CGFloat = 10

        let xOffsetLeft = 20.0 // Position from the left side
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
