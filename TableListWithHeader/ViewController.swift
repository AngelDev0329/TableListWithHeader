//
//  ViewController.swift
//  TableListWithHeader
//
//  Created by Milan on 3/8/20.
//  Copyright © 2020 667.Co.Ltd. All rights reserved.
//

import UIKit

struct Symptom: Decodable {
    var name = ""
    var regions = [Int]()
}

struct Person: Decodable {
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var address: String = ""
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let symptomsDic:[String:[Int]] = [
        "Abdominal Pain": [57,58,59],
        "Ankle Pain": [73,21,23,22,74,75],
        "Anterior Neck Pain": [1],
        "Anterior Rib Pain": [46,56,57],
        "Anterior Shoulder Pain": [46,47],
        "Anterior Thigh Pain": [59,25,26,27],
        "Buttock Pain": [62,63,64,65,66],
        "Calf Pain": [71,72,73],
        "Central Pelvic Pain": [62,64],
        "Cervico-Thoracic Junction Pain": [30,31,33],
        "Chest Pain": [46,56,57],
        "Ear Pain": [4],
        "Elbow Pain": [38,39,49],
        "Eye Pain": [5],
        "Finger Pain": [41,42,43,44,45,51,52,53,54,55],
        "Flank Pain": [29,36,56,58],
        "Forearm Pain": [39,40,50],
        "Groin Pain": [25,26,59],
        "Hand Pain": [41,42,43,44,45,51,52,53,54,55],
        "Headache": [2,6,7,8,9,32,34],
        "Heel Pain": [10,74,75],
        "Jaw Pain": [3],
        "Knee Pain": [24,70],
        "Lateral Ankle Pain Heel Pain": [26,27,65,66,69],
        "Lateral Hip Pain": [2,31,32],
        "Lateral Neck Pain": [60,61,62,63,64,65,66],
        "Lower Back Pain": [60,61,62,63,64,65,66],
        "Mid Thoracic Pain": [30,31,33,35,60],
        "Plantar Foot Pain": [10,11,12,13,14,15,16,17],
        "Posterior Neck Pain": [2,30,31,32],
        "Posterior Shoulder Pain": [30,31,33,35,37],
        "Posterior Thigh Pain": [67,68,69],
        "Sacral Pain": [62,63,64],
        "Sacroiliac Pain": [62,63,64,65,66],
        "Scapular Pain": [31,33,34,35,36,37],
        "Shin Pain": [21,22,23],
        "Spinal Pain": [30,33,60],
        "Thumb Pain": [41,51],
        "Toe Pain": [14,15,16,17],
        "Upper Arm Pain": [37,38,39,47,48,49],
        "Wrist Pain": [40,41,45,50,51,55]
    ]
    
    var symptoms = [Symptom]()
    var tblDataSource = [String : [Symptom]]()
    var sectionTitles = [String]()
    
    
    var users = [Person]()
    var dataSource = [String: [Person]]()
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
//        loadUserData()
    }
    
    fileprivate func loadUserData() {
        
    }

    fileprivate func loadData() {
         
        for one in symptomsDic {
            
            var symp = Symptom()
            
            symp.name = one.key
            symp.regions = one.value
            
            symptoms.append(symp)
        }
        
        symptoms.sort(by: { $0.name < $1.name })
        
        sectionTitles = symptoms.map { (sym) -> String in
            return String(sym.name.prefix(1))
        }.sorted()
        
        sectionTitles = sectionTitles.reduce([], { (list, name) -> [String] in
            if !list.contains(name) {
                return list + [name]
            }
            
            return list
        })
        
        for entry in symptoms {
            let startStr:String = String(entry.name.prefix(1))
            
            if tblDataSource[startStr] == nil {
                tblDataSource[startStr] = [Symptom]()
            }
            
            tblDataSource[startStr]?.append(entry)
        }
        
        let sortedKeysAndValues = tblDataSource.sorted(by: { $0.0 < $1.0 }) // sorting by dictionary key
        
        for (key, value) in sortedKeysAndValues {
            print(key)
            value.forEach { (sym) in
                print(sym.name)
            }
        }
        
        myTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        return tblDataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        let sectionKey = sectionTitles[section]
        if let rowValues = tblDataSource[sectionKey] {
            return rowValues.count
        }
            
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 3
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
          
        // Configure the cell...
        let sectionKey = sectionTitles[indexPath.section]
        
        if let rowValues = tblDataSource[sectionKey] {
            
            cell.lblCarName.text = rowValues[indexPath.row].name
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
}


