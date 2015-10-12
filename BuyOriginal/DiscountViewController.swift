//
//  BusDisViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-08.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class DiscountViewController: UITableViewController, UIAlertViewDelegate {

    var cellBrand: BOBrandTableViewCell?
    var cellStartDate: BOBusDisDateTableViewCell?
    var cellEndDate: BOBusDisDateTableViewCell?
    var cellNote: BOBusDisNotesTableViewCell?
    var cellPrecentage: BOBusDisPercentageTableViewCell?
    var cellAction: BOBusDisActionTableViewCell?
    
    
    var account: AccountModel?
    var discount: DiscountModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let backBtn = UIBarButtonItem(title: " خروج >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        if let font = UIFont(name: "system", size: 74) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!;
        
        switch (indexPath.row) {
            case 0:
                self.cellBrand = self.tableView.dequeueReusableCellWithIdentifier("cellBrand") as? BOBrandTableViewCell;
                cellBrand?.brandNameLabel.text = self.account?.brand.bName;
                cellBrand?.categoryOrStoreNoLabel.text = self.account?.brand.bCategory;
                cellBrand?.brandImageView.image = UIImage(named: self.account!.brand.bLogo!);
                cellBrand?.brandImageView.layer.cornerRadius = 8.0
                cellBrand?.brandImageView.clipsToBounds = true
                cellBrand?.brandNameLabel.hidden=false;
                return self.cellBrand!;
            case 1:
                self.cellStartDate = self.tableView.dequeueReusableCellWithIdentifier("cellStartDate") as? BOBusDisDateTableViewCell;
                
                if (self.account?.discount.startDateStrFa != nil){
                
                    let startDate:String? = self.account?.discount.startDateStrFa!;
                
                    // Year
                    let y1=startDate!.startIndex.advancedBy(2);
                    let y2=startDate!.startIndex.advancedBy(3);
                    let startYear = String(startDate![y1]) + String(startDate![y2]);
                    self.cellStartDate?.disDateYear.text = startYear;
                    
                    // Month
                    let m1=startDate!.startIndex.advancedBy(5);
                    let m2=startDate!.startIndex.advancedBy(6);
                    let startMonth = String(startDate![m1]) + String(startDate![m2]);
                    self.cellStartDate?.disDateMonth.text = startMonth;
                    
                    // Day
                    let d1=startDate!.startIndex.advancedBy(8);
                    let d2=startDate!.startIndex.advancedBy(9);
                    let startDay = String(startDate![d1]) + String(startDate![d2]);
                    self.cellStartDate?.disDateDay.text = startDay;
                    
                }
                return self.cellStartDate!;
            
            case 2:
                self.cellEndDate = self.tableView.dequeueReusableCellWithIdentifier("cellEndDate") as? BOBusDisDateTableViewCell;
                
                if (self.account?.discount.endDateStrFa != nil){
                
                let endDate:String! = self.account?.discount.endDateStrFa!;
                
                    // Year
                    let y1=endDate!.startIndex.advancedBy(2);
                    let y2=endDate!.startIndex.advancedBy(3);
                    let endYear = String(endDate![y1]) + String(endDate![y2]);
                    self.cellEndDate?.disDateYear.text = endYear;
                    
                    // Month
                    let m1=endDate!.startIndex.advancedBy(5);
                    let m2=endDate!.startIndex.advancedBy(6);
                    let endMonth = String(endDate![m1]) + String(endDate![m2]);
                    self.cellEndDate?.disDateMonth.text = endMonth;
                    
                    // Day
                    let d1=endDate!.startIndex.advancedBy(8);
                    let d2=endDate!.startIndex.advancedBy(9);
                    let endDay = String(endDate![d1]) + String(endDate![d2]);
                    self.cellEndDate?.disDateDay.text = endDay;
                    
                }
                return self.cellEndDate!;
            
            case 3:
                
                self.cellPrecentage = self.tableView.dequeueReusableCellWithIdentifier("cellPrecentage") as? BOBusDisPercentageTableViewCell;
                
                if (self.account?.discount.precentage != nil){
                    self.cellPrecentage?.percentage.text = self.account?.discount.precentage;
                }
                return self.cellPrecentage!;
            
            case 4:
                
                self.cellNote = self.tableView.dequeueReusableCellWithIdentifier("cellNote") as? BOBusDisNotesTableViewCell;
                
                if (self.account?.discount.note != nil){
                    self.cellNote?.note.text = self.account?.discount.note;
                }
                return self.cellNote!;
            case 5:
                self.cellAction = self.tableView.dequeueReusableCellWithIdentifier("cellAction") as? BOBusDisActionTableViewCell;
                return self.cellAction!;
            default:
                cell = nil;
        }
        
        
        /*
        var cell:BOStoresTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellStore") as! BOStoresTableViewCell
        
        var store = self.storesArray[indexPath.row] as! StoreModel
        
        if is_searching==true {
            store = self.filteredStores[indexPath.row] as StoreModel
        } else {
            store = self.storesArray[indexPath.row] as! StoreModel
        }
        
        cell.storeNameLabel.text = store.sName;
        cell.storeLocationLabel.text = store.sAddress
        cell.storePhoneNumberLabel.text = store.sTel1;
        cell.storeHoursLabel.text = store.sHours;
        
        if ((store.sVerified=="Yes") && (store.sDiscount>0)){
            cell.storeImageView.image = UIImage(named: "discount+verified");
        }
        else if (store.sDiscount>0){
            cell.storeImageView.image = UIImage(named: "discount+verified");
        }
        else if (store.sVerified=="Yes"){
            cell.storeImageView.image = UIImage(named: "verified");
        }
        
        // cell.textLabel?.text = self.items[indexPath.row]
        */
        return cell
        
    }
    
    func clearTextFields()->() {
        
        self.cellStartDate?.disDateYear.text = "";
        self.cellStartDate?.disDateMonth.text = "";
        self.cellStartDate?.disDateDay.text = "";
        
        self.cellEndDate?.disDateYear.text = "";
        self.cellEndDate?.disDateMonth.text = "";
        self.cellEndDate?.disDateDay.text = "";
        
        self.cellNote?.note.text = "";
        
        self.cellPrecentage?.percentage.text="";
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.row) {
        case 0:
            return 60;
        case 1:
            return 85;
        case 2:
            return 85;
        case 3:
            return 85;
        case 4:
            return 85;
        case 5:
            return 60;
        default:
            return 0;
        }
    }
    
    @IBAction func backPressed () {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    @IBAction func savePressed () {
        if (self.validateForm()==true){
            self.generateDiscountsObj();

            let httpPost = BOHttpPost()
        
            self.cellAction?.saveBtn.enabled = false;
        
            httpPost.addDiscount(self.account!, discount: self.discount!) { (result) -> Void in
                self.cellAction?.saveBtn.enabled = true;
                print("Registeration Successful");
                if (result=="success"){
                    let alert = UIAlertView(title: "", message: "حراج شما با موفقیت ثبت شد",
                        delegate: self, cancelButtonTitle: "ادامه");
                    alert.tag=1;
                    alert.show()
                }
                else {
                    let alert = UIAlertView(title: "", message: "خطادر ثبت حراج",
                        delegate: self, cancelButtonTitle: "ادامه");
                    alert.tag=2;
                    alert.show()
                }
            };
        }
        
    }
    
    
    @IBAction func deleteDiscountPressed () {
    
        let alert = UIAlertView()
        alert.title = ""
        alert.message = "آیا مطمین هستید؟"
        alert.addButtonWithTitle("بله")
        alert.addButtonWithTitle("خیر")
        alert.tag = 3
        alert.show()
        
    }
    
    func deleteDiscount() {
        
        let httpPost = BOHttpPost();
        
        let bid = self.account?.brand.bId;
        let sid = self.account?.store.sId;
        
        self.cellAction?.deleteBtn.enabled = false;
        httpPost.deleteDiscount(sid!, bId: bid!) { (result) -> Void in
            self.cellAction?.deleteBtn.enabled = true;
            print("Delete discount completed");
            if (result == "success"){
                self.clearTextFields();
            }
            else {
                let alert = UIAlertView()
                alert.title = ""
                alert.message = "خطادر حذف حراج، دوباره تلاش کنید"
                alert.addButtonWithTitle("ادامه")
                alert.tag = 4
                alert.show()
            }
        };
    }
    
    

    
    
    
    func generateDiscountsObj () {
        
        // Validation
        // Start Date is not in the past
        var err = Int();
        var errMsg = String();
        
    
        let sYear = self.cellStartDate?.disDateYear.text;
        var sMonth:String! = self.cellStartDate?.disDateMonth.text as String!;
        var sDay:String! = self.cellStartDate?.disDateDay.text as String!;
        
        
        if (sMonth.characters.count < 2){
            sMonth = "0" + sMonth;
        }
        
        if (sDay.characters.count < 2) {
            sDay = "0" + sDay;
        }
        
        let eYear = self.cellEndDate?.disDateYear.text;
        var eMonth = self.cellEndDate?.disDateMonth.text as String!;
        var eDay = self.cellEndDate?.disDateDay.text as String!;
        
        if (eMonth.characters.count < 2) {
            eMonth = "0" + eMonth;
        }
        
        if (eDay.characters.count<2) {
            eDay = "0" + eDay;
        }
        
        
        let startDateValidation = sYear! + sMonth! + sDay!;
        let endDateValidation = eYear! + eMonth! + eDay!;
        
        if (Int(startDateValidation)==nil)
        {
            err = GlobalConstants.DISCOUNT_ADD_INVALID_DATE;
            errMsg = " تاریخ شروع حراج معتبر نیست" ;
        }
        
        if (Int(endDateValidation)==nil)
        {
            err = GlobalConstants.DISCOUNT_ADD_INVALID_DATE;
            errMsg = " تاریخ پایان حراج معتبر نیست" ;
        }
      
        
        let startDate = "13" + sYear!+"/"+sMonth!+"/"+sDay!;
        let endDate = "13" + eYear!+"/"+eMonth!+"/"+eDay!;
        
        
        print ("Discount Manger: Start"+startDate);
        print ("Discount Manger: End"+endDate);
        print ("Error"+String(err)+errMsg);
        
        // remove
        // startDate = "1394/01/12";
        // endDate = "1395/02/11";
        
        self.discount = DiscountModel(startDateStrFa: startDate, endDateStrFa: endDate, precentage: self.cellPrecentage?.percentage.text, note: self.cellNote?.note.text);
        
    }
    
    
    func validateForm () -> Bool{
        
        var err=0;
        var errMsg="";
        
        
        if (self.cellStartDate?.disDateYear.text!.isEmpty == true ||
            self.cellStartDate?.disDateMonth.text!.isEmpty == true ||
            self.cellStartDate?.disDateDay.text!.isEmpty == true ||
            self.cellEndDate?.disDateYear.text!.isEmpty == true ||
            self.cellEndDate?.disDateMonth.text!.isEmpty == true ||
            self.cellEndDate?.disDateDay.text!.isEmpty == true)
        {
            err = GlobalConstants.DISCOUNT_ADD_INCOMPLETE_DATE;
            errMsg = "لطفااطلاعات مرتبط با تاریخ حراج را وارد نمایید" ;
        }
        
        if (self.cellNote?.note.text!.isEmpty == true &&
            self.cellPrecentage?.percentage.text!.isEmpty == true) {
           
            err = GlobalConstants.DISCOUNT_ADD_DISCOUNT_DETAILS_REQUIRED;
            errMsg = "درصد تخفیف یا شرح تخفیف را وارد کنید" ;
        }
        
        if (err>0){
            let alert = UIAlertView()
            alert.title = ""
            alert.message = errMsg
            alert.addButtonWithTitle("ادامه")
            alert.tag = 1
            alert.show()
            return false;
        }
        
        return true;
       
    }
    
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int)
    {
        if alertView.tag==3
        {
            if buttonIndex==0
            {
                print("حذف حراج");
                self.deleteDiscount();
            }
        }
    }
    
    
}
