//
//  ResultVC.swift
//  8:88
//
//  Created by Javier Roberto on 14/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit
import TransitionTreasury

class ResultVC: UIViewController {

    weak var modalDelegate: ModalViewControllerDelegate?
    
    lazy var testButton: UIBarButtonItem = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action: #selector(presentAnimation), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(ResultCell.self, forCellReuseIdentifier: "cell")
        table.separatorStyle = .none
        table.backgroundColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 0.1)
        return table
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()

        let resultVM = ResultVM()
        resultVM.requestInitialState(tableView)
    }
    
    
    func setupView() {
        view.addSubview(tableView)
        navigationItem.setRightBarButton(testButton, animated: true)
    }
 
    func setupConstraints() {
        tableView.fit(to: view)
    }
    
    @objc func presentAnimation() {
//        let cells = tableView.visibleCells(in: 0)
//        let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
//        UIView.animate(views: cells, animations: animations)
    }
}

extension ResultVC: UITableViewDelegate {
    
}

extension ResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        
        cell.timeLabel.text = "time"
        cell.dateLabel.text = "date"
        
        return cell
    }
}
