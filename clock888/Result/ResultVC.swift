//
//  ResultVC.swift
//  8:88
//
//  Created by Javier Roberto on 14/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit
import TransitionTreasury
import CoreData

class ResultVC: UIViewController {

    var resultArray: [NSManagedObject] = []
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
//        table.backgroundColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 0.1)
        table.backgroundColor = .white
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
        
        
        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Result")
        
        //3
        do {
            resultArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
 

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
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        
        cell.dateLabel.text = "date"
        let result = resultArray[indexPath.row]
        cell.timeLabel.text =
            result.value(forKeyPath: "time") as? String
        return cell
    }
}
