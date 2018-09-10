//
//  ViewController.swift
//  clock888
//
//  Created by Javier Roberto on 10/09/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var clockView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    lazy var clockLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue 
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()

    }
    
    func setupView() {
        view.addSubview(clockView)
        clockView.addSubview(clockLabel)
    }
    
    func setupConstraints() {
        clockLabel.fit(to: clockView, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        clockView.center(into: view)
    }
}

