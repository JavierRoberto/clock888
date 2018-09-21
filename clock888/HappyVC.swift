//
//  HappyVC.swift
//  clock888
//
//  Created by Javier Roberto on 20/09/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit
import TransitionTreasury
import TransitionAnimation

class HappyVC: UIViewController {

    weak var modalDelegate: ModalViewControllerDelegate?
    let heightDismissButton: CGFloat = 60
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 0.1)
        return view
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "happy")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var noLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Well done!"
        label.sizeToFit()
        label.font = UIFont(name: "Hero", size: 46)
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Just a 3% of people ..."
        label.font = UIFont(name: "Hero", size: 20)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share your result", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "Hero", size: 26)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1)
        button.setImage(UIImage(named: "Share"), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 32
        return button
    }()
    
    lazy var playAgainButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play again", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "Hero", size: 26)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.setTitleColor(UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "playAgain"), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 32
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
        
    }
    
    func setupView() {
        view.addSubview(topView)
        view.addSubview(dismissButton)
        view.addSubview(playAgainButton)
        topView.addSubview(icon)
        topView.addSubview(noLabel)
        topView.addSubview(descriptionLabel)
    }
    
    
    
    
    func setupConstraints() {
        
        
        topView.fit(toTop: view)
        noLabel.center(into: topView)
        descriptionLabel.fit(horizontal: view, below: noLabel, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        noLabel.fit(horizontal: view, below: icon, insets: UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0))
        
        
        NSLayoutConstraint.activate([
            
            topView.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: heightDismissButton / 2),
            
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 128),
            icon.widthAnchor.constraint(equalToConstant: 128),
            
            dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            dismissButton.heightAnchor.constraint(equalToConstant: heightDismissButton),
            
            playAgainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            playAgainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            playAgainButton.heightAnchor.constraint(equalToConstant: heightDismissButton),
            playAgainButton.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 10)
            
            ])
    }

    @objc func dismissView() {
        modalDelegate?.modalViewControllerDismiss(callbackData: nil)
    }
}
