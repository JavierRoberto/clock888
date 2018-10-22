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
    let heightshareButton: CGFloat = 60
    
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
        label.text = "well_done".localized
        label.sizeToFit()
        label.font = UIFont(name: "Hero", size: 46)
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "just_people".localized
        label.font = UIFont(name: "Hero", size: 20)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("share_result".localized, for: .normal)
        
        button.titleLabel?.font = UIFont(name: "Hero", size: 26)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action: #selector(share(sender:)), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 32
        return button
    }()
    
    lazy var playAgainButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("play_again".localized, for: .normal)
        
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
        view.addSubview(shareButton)
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
            
            topView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: heightshareButton / 2),
            
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 128),
            icon.widthAnchor.constraint(equalToConstant: 128),
            
            shareButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            shareButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            shareButton.heightAnchor.constraint(equalToConstant: heightshareButton),
            
            playAgainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            playAgainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            playAgainButton.heightAnchor.constraint(equalToConstant: heightshareButton),
            playAgainButton.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 10)
            
            ])
    }

    @objc func dismissView() {
        modalDelegate?.modalViewControllerDismiss(callbackData: nil)
    }
    
    @objc func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "Check out my app"
        
        if let myWebsite = URL(string: "https://itunes.apple.com/us/app/whatsapp-messenger/id1437303312?mt=8") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }    }
}
