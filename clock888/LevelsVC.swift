//
//  LevelsVC.swift
//  8:88
//
//  Created by Javier Roberto on 22/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit


enum Level: Int {
    case bronze = 1
    case silver = 2
    case gold = 3
}

class LevelsVC: UIViewController {

    var levelSelected: Level = .bronze
    
    var delegate: ViewControllerDelegate?

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topView, bottomView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(displayP3Red: 254/255, green: 240/255, blue: 236/255, alpha: 1)
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "menu_key".localized
        label.font = UIFont(name: "Hero", size: 30)
        label.textColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1)
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 0.5 * 40
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        

        return button
    }()
    
    lazy var bronzeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("newbie_key".localized, for: .normal)
        button.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 1)
        button.addTarget(self, action: #selector(selectLevel), for: .touchUpInside)
        button.tag = Level.bronze.rawValue
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        button.layer.cornerRadius = 32

        return button
    }()
    
    lazy var silverButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("middle_key".localized, for: .normal)
        button.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 1)
        button.addTarget(self, action: #selector(selectLevel), for: .touchUpInside)
        button.tag = Level.silver.rawValue
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        button.layer.cornerRadius = 32
        return button
    }()
    
    lazy var goldButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("pro_key".localized, for: .normal)
        button.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 1)
        button.addTarget(self, action: #selector(selectLevel), for: .touchUpInside)
        button.tag = Level.gold.rawValue
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        button.layer.cornerRadius = 32

        return button
    }()
    
    lazy var stackLevelSelector: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bronzeButton, silverButton, goldButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30
        return stack
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "description_levels_key".localized
        label.font = UIFont(name: "Hero", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.alpha = 0.7
        
        setupView()
        setupConstraints()
        
    }
    
    func setupView() {
        view.addSubview(stack)
        stack.addSubview(titleLabel)
        stack.addSubview(stackLevelSelector)
        stack.addSubview(descriptionLabel)
        view.addSubview(closeButton)
    }
 
    func setupConstraints() {
        let navbarHeight = navigationController?.navigationBar.frame.maxY ?? 44
//        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: navbarHeight + 100).isActive = true
//        stack.fit(toBottom: view, insets: UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20))
        
        stack.fit(to: view)
//        stackLevelSelector.fit(horizontal: stack, below: titleLabel, insets: UIEdgeInsets(top: 80, left: 20, bottom: 20, right: 20))
        stackLevelSelector.center(into: stack)
        
        descriptionLabel.fit(horizontal: stack, below: stackLevelSelector, insets: UIEdgeInsets(top: 80, left: 20, bottom: 20, right: 20))
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: navbarHeight + 20),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: stack.topAnchor, constant: navbarHeight + 20),
            titleLabel.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            stackLevelSelector.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 20),
            stackLevelSelector.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -20)
            ])
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectLevel(sender:UIButton) {
        switch sender.tag {
        case Level.bronze.rawValue:
            levelSelected = .bronze
            closeView()
            break
        case Level.silver.rawValue:
            levelSelected = .silver
            closeView()
            break
        case Level.gold.rawValue:
            levelSelected = .gold
            closeView()
            break
        default: break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.pass(level: levelSelected)
    }
}


