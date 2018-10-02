//
//  StringExtension.swift
//  8:88
//
//  Created by Javier Roberto on 02/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
