//
//  ResultCell.swift
//  8:88
//
//  Created by Javier Roberto on 14/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "ddfffff"
        label.sizeToFit()
        label.font = UIFont(name: "Hero", size: 20)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hero", size: 20)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 254/255, green: 240/255, blue: 236/255, alpha: 1)
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 1
        view.layer.shouldRasterize = true
//        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        return view
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel/*, dateLabel*/])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = .white
        contentView.addSubview(container)
        container.addSubview(stack)
        
    }
    
    func setupConstraints() {
        container.fit(to: contentView, insets: UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20))
        stack.fit(to: container, insets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }

}
