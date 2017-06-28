

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // MARK: - StoryBoard variable
    
    @IBOutlet weak var relationShipTableView: UITableView!
    
    // MARK: - Generic variables
    
    var relDict : [Dictionary<String , Any>?] = []
    var relManipulatedDict : [Dictionary<String , Any>?] = []
    var grandParentList  : Array<String>! = []
    var parentList  : Array<String>! = []
    var meList  : Array<String>! = []
    var grandChildList  : Array<String>! = []
    var relationList  : Array<String>! = []
    var isParent : Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resgisterAllCellfromNib()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Methods
    
    func resgisterAllCellfromNib()  {
        
        self.relManipulatedDict.append(["CLabel":["me"]])
        
        let grandParentNib = UINib(nibName: "GrandParentTableViewCell", bundle: nil)
        self.relationShipTableView.register(grandParentNib, forCellReuseIdentifier: "grandParent")
        
        let parentNib = UINib(nibName: "ParentTableViewCell", bundle: nil)
        self.relationShipTableView.register(parentNib, forCellReuseIdentifier: "parent")
        
        let meNib = UINib(nibName: "MeTableViewCell", bundle: nil)
        self.relationShipTableView.register(meNib, forCellReuseIdentifier: "me")
        
        let grandChildNib = UINib(nibName: "GrandChildTableViewCell", bundle: nil)
        self.relationShipTableView.register(grandChildNib, forCellReuseIdentifier: "grandChild")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relManipulatedDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell?
        
        
        let roleKey = self.relManipulatedDict[indexPath.row]!
        
        if roleKey.keys.first == "ALabel" {
            let identifier: String = "grandParent"
            let grandParentCell: GrandParentTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: identifier) as! GrandParentTableViewCell)
            grandParentCell?.grandParentList = roleKey["ALabel"] as! Array
            cell  = grandParentCell
            
    
           
        }else if (roleKey.keys.first == "BLabel"){
            let identifier: String = "parent"
            let parentCell: ParentTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: identifier) as! ParentTableViewCell)
             parentCell?.parentList = roleKey["BLabel"] as! Array
            self.isParent = true
            cell  = parentCell

        }else if(roleKey.keys.first == "CLabel"){
            let identifier: String = "me"
            let meCell: MeTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: identifier) as! MeTableViewCell)
             meCell?.meList = roleKey["CLabel"] as! Array
            cell  = meCell
        }else{
            let identifier: String = "grandChild"
            let grandChildCell: GrandChildTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: identifier) as! GrandChildTableViewCell)
             grandChildCell?.grandChildList = roleKey["DLabel"] as! Array
            cell  = grandChildCell
            
        }
        
        
        cell?.setNeedsDisplay()
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
     // MARK: - Button action
    
    @IBAction func onAddFamilyBtnClick(_ sender: UIButton) {
        self.showRelationSheet()
    }
    
    
    // MARK: - UI handler and business methods
    
    func showRelationSheet() {
        let actionSheetController = UIAlertController(title: NSLocalizedString("Relations", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in}
        actionSheetController.addAction(cancelActionButton)
        
        let fatherGrandFatherButton = UIAlertAction(title: NSLocalizedString("Grand Father", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Grand Father") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            if (self.isParent == true){
            self.grandParentList.append("Grand Father")
            self.removeSameObject(withKey: "ALabel")
            let gpDict = ["ALabel" : self.grandParentList] as Dictionary<String,Any>
            self.relDict.append(gpDict)
            self.manipulateListToArrangeRelation()
            self.relationShipTableView.reloadData()
            self.relationList.append("Grand Father")
            }else{
                self.showAlert(message: "Please Select Father First")
            }
            
        }
        actionSheetController.addAction(fatherGrandFatherButton)
        
        let fatherGrandMotherButton = UIAlertAction(title:  NSLocalizedString("Grand Mother", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Grand Mother") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            if(self.isParent == true){
            self.grandParentList.append("Grand Mother")
            self.removeSameObject(withKey: "ALabel")
            let gpDict = ["ALabel" : self.grandParentList] as Dictionary<String,Any>
            self.relDict.append(gpDict)
            self.manipulateListToArrangeRelation()
            self.relationShipTableView.reloadData()
            self.relationList.append("Grand Mother")
            }
            else{
                self.showAlert(message: "Please Select Father First")
            }

        }
        actionSheetController.addAction(fatherGrandMotherButton)
        
        let motherGrandFatherButton = UIAlertAction(title:  NSLocalizedString("Grand Father In Law", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Grand Father In Law") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            if(self.isParent == true){
            self.grandParentList.append("Grand Father In Law")
            self.removeSameObject(withKey: "ALabel")
            let gpDict = ["ALabel" : self.grandParentList] as Dictionary<String,Any>
            self.relDict.append(gpDict)
            self.manipulateListToArrangeRelation()
            self.relationShipTableView.reloadData()
            self.relationList.append("Grand Father In Law")
            }else{
                 self.showAlert(message: "Please Select Father First")
            }
        }
        actionSheetController.addAction(motherGrandFatherButton)
        
        let motherGrandMotherButton = UIAlertAction(title:  NSLocalizedString("Grand Mother In Law", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Grand Mother In Law") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            if(self.isParent == true){
            self.grandParentList.append("Grand Mother In Law")
            self.removeSameObject(withKey: "ALabel")
            let gpDict = ["ALabel" : self.grandParentList] as Dictionary<String,Any>
            self.relDict.append(gpDict)
            self.manipulateListToArrangeRelation()
            self.relationShipTableView.reloadData()
            self.relationList.append("Grand Mother In Law")
            }else{
                 self.showAlert(message: "Please Select Father First")
            }
        }
        actionSheetController.addAction(motherGrandMotherButton)
        
        let fatherButton = UIAlertAction(title:  NSLocalizedString("Father", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Father") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            self.parentList.append("Father")
            self.removeSameObject(withKey: "BLabel")
            let parentDict = ["BLabel" : self.parentList] as Dictionary<String,Any>
            self.relDict.append(parentDict)
            self.manipulateListToArrangeRelation()
            self.relationShipTableView.reloadData()
            self.relationList.append("Father")
        }
        actionSheetController.addAction(fatherButton)

        
        let motherButton = UIAlertAction(title:  NSLocalizedString("Mother", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Mother") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            self.parentList.append("Mother")
             self.removeSameObject(withKey: "BLabel")
            let parentDict = ["BLabel" : self.parentList] as Dictionary<String,Any>
            self.relDict.append(parentDict)
            self.manipulateListToArrangeRelation()
             self.relationShipTableView.reloadData()
            self.relationList.append("Mother")
        }
        actionSheetController.addAction(motherButton)
        
        
        let wifeButton = UIAlertAction(title:  NSLocalizedString("Wife", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Wife") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            if !self.meList.contains("me") {
                self.meList.append("me")
            }
            self.meList.append("Wife")
            
            self.removeSameObject(withKey: "CLabel")
            let meDict = ["CLabel" : self.meList] as Dictionary<String,Any>
            self.relDict.append(meDict)
            self.manipulateListToArrangeRelation()
             self.relationShipTableView.reloadData()
            self.relationList.append("Wife")
            
        }
        actionSheetController.addAction(wifeButton)
        
        let sisterInlawButton = UIAlertAction(title:  NSLocalizedString("Sister In Law", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Sister In Law") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            self.meList.append("Sister In Law")
            if !self.meList.contains("me") {
                self.meList.append("me")
            }
             self.removeSameObject(withKey: "CLabel")
            let meDict = ["CLabel" : self.meList] as Dictionary<String,Any>
            self.relDict.append(meDict)
            self.manipulateListToArrangeRelation()
             self.relationShipTableView.reloadData()
            self.relationList.append("Sister In Law")
            
        }
        actionSheetController.addAction(sisterInlawButton)
        
        let brotherButton = UIAlertAction(title:  NSLocalizedString("Brother", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Brother") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            self.meList.append("Brother")
            if !self.meList.contains("me") {
                self.meList.append("me")
            }
            self.removeSameObject(withKey: "CLabel")
            let meDict = ["CLabel" : self.meList] as Dictionary<String,Any>
            self.relDict.append(meDict)
            self.manipulateListToArrangeRelation()
            self.relationShipTableView.reloadData()
            self.relationList.append("Brother")
            
        }
        actionSheetController.addAction(brotherButton)
        
        let nephewButton = UIAlertAction(title:  NSLocalizedString("Nephew", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Nephew") == true){
                self.showAlert(message: "Relation already added")
                return
            }
            
            self.grandChildList.append("Nephew")
            self.removeSameObject(withKey: "DLabel")
            let grandChild = ["DLabel" : self.grandChildList] as Dictionary<String,Any>
            self.relDict.append(grandChild)
            self.manipulateListToArrangeRelation()
             self.relationShipTableView.reloadData()
            self.relationList.append("Nephew")
            
        }
        actionSheetController.addAction(nephewButton)
        
        
        let nieceButton = UIAlertAction(title:  NSLocalizedString("Niece", comment: ""), style: .default) { action -> Void in
            
            if(self.checkIfrelationIsAlreadySelected(withRel: "Niece") == true){
                self.showAlert(message: "Relation already added")
                return
            }

            
            self.grandChildList.append("Niece")
            self.removeSameObject(withKey: "DLabel")
            let grandChild = ["DLabel" : self.grandChildList] as Dictionary<String,Any>
            self.relDict.append(grandChild)
            self.manipulateListToArrangeRelation()
            self.relationShipTableView.reloadData()
            self.relationList.append("Niece")
            
        }
        actionSheetController.addAction(nieceButton)
        actionSheetController.view.tintColor = UIColor.black
        self.present(actionSheetController, animated: true, completion: {
           
            })
        }
    
    func removeSameObject(withKey:String)  {
        
        for item in self.relDict {
            if item?.keys.first == withKey {
                let index = self.relDict.index(where: { (item) -> Bool in
                    item?.keys.first == withKey
                })
                
                self.relDict.remove(at: index!)
            }
        }
        
    }
    
    func removeSameObjectInManipulatedDict(withKey:String)  {
        
        for item in self.relManipulatedDict {
            if item?.keys.first == withKey {
                let index = self.relManipulatedDict.index(where: { (item) -> Bool in
                    item?.keys.first == withKey
                })
                
                self.relManipulatedDict.remove(at: index!)
            }
        }
        
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func checkIfrelationIsAlreadySelected(withRel:String) -> Bool {
        if relationList.contains(withRel) {
            return true
        }
        return false
    }
    
    func manipulateListToArrangeRelation()  {
        
        for item in self.relDict {
            
            if item?.keys.first == "grandChild" {
                self.removeSameObjectInManipulatedDict(withKey: (item?.keys.first)!)
                self.relManipulatedDict.insert(item, at: 0)
            }else if item?.keys.first == "me"{
                self.removeSameObjectInManipulatedDict(withKey: (item?.keys.first)!)
                self.manipulateLoaderDict(withKey: "me", item: item)
                
            }
            else if item?.keys.first == "parent"{
                self.removeSameObjectInManipulatedDict(withKey: (item?.keys.first)!)
                self.manipulateLoaderDict(withKey: "parent", item: item)
                
            }
            else{
                self.removeSameObjectInManipulatedDict(withKey: (item?.keys.first)!)
                self.manipulateLoaderDict(withKey: "grandParent", item: item)
                
            }
        }
    }
    
    
    func manipulateLoaderDict(withKey:String,item:Dictionary<String , Any>?)  {
        let index = self.relManipulatedDict.index(where: { (item) -> Bool in
            item?.keys.first == withKey
        })
        if (index != nil) {
            self.relManipulatedDict.insert(item, at: index!)
        }else{
            self.relManipulatedDict.append(item)
        }

        
        self.relManipulatedDict.sort {
            guard let leftValue = $0 as Dictionary<String , Any>?, let rightValue = $1 as Dictionary<String , Any>? else {
                return false // NOTE: you will need to decide how to handle missing keys.
            }
            
            return (leftValue.keys.first )!.localizedStandardCompare(rightValue.keys.first!) == .orderedAscending
        }
        
    }

    
}

