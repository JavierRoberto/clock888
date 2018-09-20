//
//  ResultVC.swift
//  clock888
//
//  Created by Javier Roberto on 20/09/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit
import TransitionTreasury
import TransitionAnimation

class ResultVC: UIViewController {

    weak var modalDelegate: ModalViewControllerDelegate?
    let heightDismissButton: CGFloat = 60
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 0.1)
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
        label.text = "Nooo!"
        label.sizeToFit()
        label.font = UIFont(name: "Hero", size: 46)
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "But you were super close.."
        label.font = UIFont(name: "Hero", size: 20)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, noLabel, descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
//        stack.alignment = .center
        return stack
    }()
    
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try again", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "Hero", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 1)
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 32
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        topView.addSubview(stackView)
        view.addSubview(topView)
        view.addSubview(dismissButton)
    }
    
    
    
    
    func setupConstraints() {
        
        stackView.fit(to: topView, insets: UIEdgeInsets(top: 130, left: 15, bottom: 15, right: 130))
        topView.fit(toTop: view)
        noLabel.center(into: topView)
        
        NSLayoutConstraint.activate([
            
            topView.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: heightDismissButton / 2),

            
            
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            icon.heightAnchor.constraint(equalToConstant: 128),
//            icon.widthAnchor.constraint(equalToConstant: 128),
            
            dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            dismissButton.heightAnchor.constraint(equalToConstant: heightDismissButton)
            
        ])
    }

    @objc func dismissView() {
        modalDelegate?.modalViewControllerDismiss(callbackData: nil)
    }
}
