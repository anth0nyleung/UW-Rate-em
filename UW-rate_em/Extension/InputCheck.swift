//
//  InputCheck.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/20/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import Foundation

extension String {
    func isDouble() -> Bool {
        if let _ = Double(self) {
            return true
        }
        return false
    }
}
