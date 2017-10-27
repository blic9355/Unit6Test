//
//  PersonController.swift
//  FinalTest
//
//  Created by Brian Licea on 10/27/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import Foundation

class PersonController {
    
    static let shared = PersonController()
    
    var people:[Person] = []
    var pairOfPeople: [[Person]] = []
    
    init() {
        loadFromPersistentStore()
        pairOfPeople = randomize(people)
    }
    
    // Mark: - Adding person
    func addPerson(withName name: String) {
        let newPerson = Person(withName: name)
        people.append(newPerson)
        if let lastGroupInPeoplePairs = pairOfPeople.last {
            if lastGroupInPeoplePairs.count % 2 != 0 {
                pairOfPeople[pairOfPeople.count - 1].append(newPerson)
            } else {
                pairOfPeople.append([newPerson])
            }
        } else {
            pairOfPeople.append([newPerson])
        }
        saveToPersistentStore()
    }
    
    // Mark: - Persistent store
    func saveToPersistentStore() {
        var personDictionaries: [[String:Any]] = []
        
        for person in people {
            let personDictionary = person.dictionaryRep
            personDictionaries.append(personDictionary)
        }
        UserDefaults.standard.set(personDictionaries, forKey: Keys.peopleKey)
    }
    func loadFromPersistentStore() {
        if let personDictionaries = UserDefaults.standard.object(forKey: Keys.peopleKey) as? [[String:Any]] {
            var people: [Person] = []
            for personDictionary in personDictionaries {
                if let storedPerson = Person(dictionary: personDictionary) {
                    people.append(storedPerson)
                }
            }
            self.people = people
        }
    }
    
    // Mark: - dictionary rep
    init?(dictionary: [String:Any]) {
        guard let personDictionaries = dictionary[Keys.peopleKey] as? [[String:Any]] else { return nil }
        var people: [Person] = []
        
        for personDictionary in personDictionaries {
            if let newPerson = Person(dictionary: personDictionary) {
                people.append(newPerson)
            }
        }
        self.people = people
    }
    
    // Mark: - Randomizer...hopefully
    func randomize(_ inputArray: [Person]) -> [[Person]] {
        
        // inputs
        var inputArray = inputArray
        var i = inputArray.count
        
        // work variables
        var tempItem1: Person
        var tempItem2: Person
        var tempRandomNum: Int
        var tempRandomNum2: Int
        
        // output
        var pairArray: [[Person]] = []
        
        while i > 0 {
            var tempPairArray:[Person] = []
            
            if inputArray.count % 2 == 0 {
                // randomly pop item1 from input array and store
                tempRandomNum = Int(arc4random_uniform(UInt32(i)))
                tempItem1 = inputArray[tempRandomNum]
                inputArray.remove(at: tempRandomNum)
                
                // ranfomly pop item2  from input array and store
                tempRandomNum2 = Int(arc4random_uniform(UInt32(i-1)))
                tempItem2 = inputArray[tempRandomNum2]
                inputArray.remove(at: tempRandomNum2)
                
                // attach both stored elements into tempArray - this tempArray is the pair
                tempPairArray.append(tempItem1)
                tempPairArray.append(tempItem2)
                
                // attach the pair array to the pairArray
                pairArray.append(tempPairArray)
                
                // decrease by two since two elements were removed from array
                i -= 2
            } else {
                // randomly pop item1 from input array and store
                tempRandomNum = Int(arc4random_uniform(UInt32(i)))
                tempItem1 = inputArray[tempRandomNum]
                inputArray.remove(at: tempRandomNum)
                
                // attach stored element into the single temparray
                tempPairArray.append(tempItem1)
                
                // attach the single array to the pairArray
                pairArray.append(tempPairArray)
                
                // decrease by one since one element was removed from array
                i -= 1
            }
        }
        pairArray.reverse()
        return pairArray
    }
}



