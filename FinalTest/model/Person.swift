//
//  Person.swift
//  FinalTest
//
//  Created by Brian Licea on 10/27/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import Foundation

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
    // come back
    init(withName name: String) {
        self.name = name
    }
    
    init?(dictionary: [String: Any]) {
        if let name = dictionary[Keys.nameKey] as? String {
            self.name = name
        } else {
            return nil
        }
    }
    var  dictionaryRep: [String: Any] {
        let dictionary: [String: Any] = [Keys.nameKey: name]
        return dictionary
    }
}
