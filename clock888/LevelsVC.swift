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

    lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.layer.cornerRadius = 16
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        return button
    }()
    
    lazy var bronzeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("bronze", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(selectLevel), for: .touchUpInside)
        button.tag = Level.bronze.rawValue
        return button
    }()
    
    lazy var silverButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("silver", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(selectLevel), for: .touchUpInside)
         button.tag = Level.silver.rawValue
        return button
    }()
    
    lazy var goldButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("gold", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(selectLevel), for: .touchUpInside)
        button.tag = Level.gold.rawValue
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bronzeButton, silverButton, goldButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.alpha = 0.7
        
        setupView()
        setupConstraints()
        
    }
    
    func setupView() {
        view.addSubview(stack)
        view.addSubview(closeButton)
    }
 
    func setupConstraints() {
        let navbarHeight = navigationController?.navigationBar.frame.maxY ?? 44
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: navbarHeight + 100).isActive = true
        stack.fit(toBottom: view, insets: UIEdgeInsets(top: 100, left: 60, bottom: 100, right: 60))
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: navbarHeight + 20),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
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


