//
//  ResultCell.swift
//  8:88
//
//  Created by Javier Roberto on 14/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    lazy var paddingView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 45).isActive = true
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.layer.cornerRadius = 0.5 * 45
        view.backgroundColor = UIColor(displayP3Red: 253/255, green: 231/255, blue: 235/255, alpha: 1)
        view.addSubview(resultImageView)
        return view
    }()
    
    lazy var resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.layer.cornerRadius = 0.5 * 24
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 1)
        label.text = ""
        label.sizeToFit()
        label.font = UIFont(name: "Hero", size: 18)
        return label
    }()
    
    lazy var levelLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1)
        label.text = ""
        label.sizeToFit()
        label.font = UIFont(name: "Hero", size: 16)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hero", size: 20)
        label.textColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 1)
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
            
        label.numberOfLines = 2
        label.textAlignment = .right
        return label
    }()
    
    lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
//    lazy var spaceView: UIView = {
//        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .orange
//        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        return view
//    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [paddingView, timeLabel, levelLabel, dateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
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
        contentView.backgroundColor = UIColor(displayP3Red: 253/255, green: 240/255, blue: 235/255, alpha: 1)
        contentView.addSubview(container)
        container.addSubview(stack)
        
    }
    
    func setupConstraints() {
        resultImageView.center(into: paddingView)
        container.fit(to: contentView, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        stack.fit(to: container, insets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        NSLayoutConstraint.activate([
            timeLabel.leftAnchor.constraint(equalTo: paddingView.rightAnchor, constant: 15),
            levelLabel.leftAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: 15)
            ])
    }
}


extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
