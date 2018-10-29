//
//  BestResultVC.swift
//  8:88
//
//  Created by Javier Roberto on 25/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit

class BestResultVC: UIViewController {

    lazy var view1: UIView = {
        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var view2: UIView = {
        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var view3: UIView = {
        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [view1, view2, view3])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stack)
        guard
            let navbarHeight = navigationController?.navigationBar.frame.maxY,
            let tabBarHeight = tabBarController?.tabBar.frame.height
        
        else { return }
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: navbarHeight),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight)
            ])
        
        stack.fit(toBottom: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "best_results".localized
    }
}
