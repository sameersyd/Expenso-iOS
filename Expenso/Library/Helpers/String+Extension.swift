//
//  String+Extension.swift
//  Expenso
//
//  Created by ahdivio mendes on 02/10/23.
//

import Foundation

extension String {
  var capitalized: String {
    
    let firstLetter = self.prefix(1).capitalized
    
    let remainingLetters = self.dropFirst().lowercased()
    
    return firstLetter + remainingLetters
  }
}
