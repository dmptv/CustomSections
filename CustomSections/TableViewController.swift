//
//  TableViewController.swift
//  CustomSections
//
//  Created by Kanat A on 13/06/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whal", "Shark", "Wombat"]
    
    var animalSectionTitles = [String]()
    var animalDict = [String : [String]]()
    var animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAnimalDict()
  
    }
    
    // заполним массив первыми неповторяющимися буквами
    func createAnimalDict() {
        for animal in animals {
            // взяли первую букву
            let animalKey = animal.substring(to: animal.index(animal.startIndex, offsetBy: 1))
            
            // проверяем есть ли уже такой ключ в словаре
            if var animalValues = animalDict[animalKey] {
                animalValues.append(animal)
                
                //  возвращаем массив с новым значением
                animalDict[animalKey] = animalValues
            } else {
                animalDict[animalKey] = [animal]
            }
        }
        // заполнили массив titles массивом ключей
        animalSectionTitles = [String](animalDict.keys) // cast LazyMapCollection to [ String ]
        
        // сорт по возрастанию
        animalSectionTitles = animalSectionTitles.sorted()
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return animalSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let animalKey = animalSectionTitles[section]
        if let animalValues = animalDict[animalKey] {
            return animalValues.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let animalKey = animalSectionTitles[indexPath.section]
        if let animalValue = animalDict[animalKey] {
            cell.textLabel?.text = animalValue[indexPath.row]
        }
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return animalIndexTitles
    }
 
    //исправим  несоответствие букв сбоку и названий секций
    // укажем точный индекс объекта из массива для title index = index of title
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = animalSectionTitles.index(of: title) else {
            return -1
        }
        return index
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // custom header view
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = .orange
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }

 
}













