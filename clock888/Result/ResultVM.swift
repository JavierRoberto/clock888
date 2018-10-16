//
//  ResultVM.swift
//  8:88
//
//  Created by Javier Roberto on 14/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit
import ViewAnimator



class ResultVM: NSObject {
    func requestInitialState(_ tableView: UITableView) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tableView.isHidden = false
            let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
            let cells = tableView.visibleCells(in: 0)
            UIView.animate(views: cells, animations: animations)
        }
        
    }
}

