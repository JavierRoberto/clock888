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
        
        view.backgroundColor = UIColor(displayP3Red: 253/255, green: 240/255, blue: 235/255, alpha: 1)
        tableView.backgroundColor = UIColor(displayP3Red: 253/255, green: 240/255, blue: 235/255, alpha: 1)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "last_10".localized
        self.title = "results_key".localized
    }
    
    
    func setupView() {
        view.addSubview(tableView)
    }
 
    func setupConstraints() {
        tableView.fit(to: view)
    }
}

extension ResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        
        let result = resultArray[indexPath.row]
        let firstPartOfDate = (result.value(forKeyPath: "timeStamp") as? Date)?.toString(dateFormat: "dd.MM.yyyy") ?? ""
        let secondPartOfDate = (result.value(forKeyPath: "timeStamp") as? Date)?.toString(dateFormat: "HH:mm") ?? ""
        let timeString = firstPartOfDate + "\n" + secondPartOfDate
        
        cell.dateLabel.text = timeString
        let level: Int = result.value(forKeyPath: "level") as? Int ?? 1
        var levelString: String = ""
        switch level {
        case Level.bronze.rawValue:
            levelString = "newbie_key".localized
        case Level.silver.rawValue:
            levelString = "middle_key".localized
        case Level.gold.rawValue:
            levelString = "pro_key".localized
        default:
            levelString = ""
        }
        cell.levelLabel.text = levelString
        let timeResult = result.value(forKeyPath: "timeResult") as? String
        cell.timeLabel.text = timeResult
        let sadImage = UIImage(named: "sad")!
        let happyImage = UIImage(named: "happy")!
        cell.resultImageView.image = timeResult == "88:88" ? happyImage : sadImage
        return cell
    }
}


