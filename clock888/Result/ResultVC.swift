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
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(frame: .zero)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.heightAnchor.constraint(equalToConstant: 30).isActive = true
        control.insertSegment(withTitle: "Last 10", at: 0, animated: true)
        control.insertSegment(withTitle: "Friends", at: 1, animated: true)
        control.layer.cornerRadius = 5.0  // Don't let background bleed
        control.backgroundColor = .black
        control.tintColor = .white
        control.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        //        control.backgroundColor = .blue
        return control
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.register(ResultCell.self, forCellReuseIdentifier: "cell")
        table.separatorStyle = .none
//        table.backgroundColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 0.1)
        table.backgroundColor = .white
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1)
        self.navigationItem.title = "last_10".localized
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Result")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false)]
        do {
            resultArray = try managedContext.fetch(fetchRequest)
            if resultArray.count > 10 {
                for i in 10...resultArray.count - 1 {
                    managedContext.delete(resultArray[i])
                }
                do {
                    try managedContext.save() // <- remember to put this :)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                resultArray = Array(resultArray.prefix(10))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        let resultVM = ResultVM()
        resultVM.requestInitialState(tableView)
    }
    
    
    func setupView() {
        view.addSubview(segmentedControl)
//        view.addSubview(tableView)
        navigationItem.setRightBarButton(testButton, animated: true)
    }
 
    func setupConstraints() {
        
        segmentedControl.fit(toTop: view, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//        tableView.fit(toBottom: view)
//        tableView.fit(horizontal: view, below: segmentedControl, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//        tableView.fit(to: view)
    }
    
    @objc func presentAnimation() {
//        let cells = tableView.visibleCells(in: 0)
//        let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
//        UIView.animate(views: cells, animations: animations)
    }
    
    @objc func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            self.view.backgroundColor = .green
        case 2:
            self.view.backgroundColor = .blue
        default:
            self.view.backgroundColor = .orange
        }
    }
}

extension ResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        
        let result = resultArray[indexPath.row]
        cell.dateLabel.text = (result.value(forKeyPath: "timeStamp") as? Date)?.description
        cell.timeLabel.text = result.value(forKeyPath: "timeResult") as? String
        return cell
    }
}
