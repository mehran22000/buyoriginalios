//
//  BusDisViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-08.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class DiscountViewController: UITableViewController {

    var cellBrand: BOBrandTableViewCell?
    var cellStartDate: BOBusDisDateTableViewCell?
    var cellEndDate: BOBusDisDateTableViewCell?
    var cellNote: BOBusDisNotesTableViewCell?
    var cellPrecentage: BOBusDisPercentageTableViewCell?
    
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
                    let rangeOfYear = Range(start: advance(startDate!.startIndex,2),
                        end: advance(startDate!.startIndex, 4));
                    let year = startDate!.substringWithRange(rangeOfYear)
                    self.cellStartDate?.disDateYear.text = year;
                
                    // Month
                    let rangeOfMonth = Range(start: advance(startDate!.startIndex,5),
                        end: advance(startDate!.startIndex, 7));
                    let month = startDate!.substringWithRange(rangeOfMonth)
                    self.cellStartDate?.disDateMonth.text = month;
                
                
                    // Day
                    let rangeOfDay = Range(start: advance(startDate!.startIndex,8),
                        end: advance(startDate!.startIndex, 10));
                    let day = startDate!.substringWithRange(rangeOfDay)
                    self.cellStartDate?.disDateDay.text = day;
                }
                return self.cellStartDate!;
            
            case 2:
                self.cellEndDate = self.tableView.dequeueReusableCellWithIdentifier("cellEndDate") as? BOBusDisDateTableViewCell;
                
                if (self.account?.discount.endDateStrFa != nil){
                
                let endDate:String! = self.account?.discount.endDateStrFa!;
                
                    // Year
                    let rangeOfYear = Range(start: advance(endDate.startIndex,2),
                        end: advance(endDate.startIndex, 4));
                    let year = endDate.substringWithRange(rangeOfYear)
                    self.cellEndDate?.disDateYear.text = year;
                
                    // Month
                    let rangeOfMonth = Range(start: advance(endDate.startIndex,5),
                        end: advance(endDate.startIndex, 7));
                    let month = endDate.substringWithRange(rangeOfMonth)
                    self.cellEndDate?.disDateMonth.text = month;
                
                
                    // Day
                    let rangeOfDay = Range(start: advance(endDate.startIndex,8),
                        end: advance(endDate.startIndex, 10));
                    let day = endDate.substringWithRange(rangeOfDay)
                    self.cellEndDate?.disDateDay.text = day;
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
                cell = self.tableView.dequeueReusableCellWithIdentifier("cellAction") as! BOBusDisActionTableViewCell;
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
        
            let okAction = UIAlertAction(title: "پایان", style:UIAlertActionStyle.Default) { (action) in
                self.navigationController?.popToRootViewControllerAnimated(false);
            }
        
            httpPost.addDiscount(self.account!, discount: self.discount!) { (result) -> Void in
                println("Registeration Successful");
                if (result=="success"){
                    let alertController = UIAlertController(title: "", message:
                        "حراج شما با موفقیت ثبت شد", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(okAction);
                    self.presentViewController(alertController, animated: true, completion: nil);

                }
                else {
                
                    let alertController = UIAlertController(title: "", message:
                    "خطادر ثبت حراج", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(okAction);
                    self.presentViewController(alertController, animated: true, completion: nil);
                }
            };
        }
        
    }
    
    
    @IBAction func deleteDiscountPressed () {
        
        let okAction = UIAlertAction(title: "بله", style:UIAlertActionStyle.Default) { (action) in
            self.deleteDiscount();
        }
        
        let cancelAction = UIAlertAction(title: "خیر", style:UIAlertActionStyle.Default) { (action) in
        }
        
        let alertController = UIAlertController(title: "", message:
            "آیا مطمین هستید؟", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(okAction);
        alertController.addAction(cancelAction);
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func deleteDiscount() {
        
        let httpPost = BOHttpPost();
        
        let bid = self.account?.brand.bId;
        let sid = self.account?.store.sId;
        
        httpPost.deleteDiscount(sid!, bId: bid!) { (result) -> Void in
            println("Delete discount completed");
            if (result == "success"){
                self.clearTextFields();
            }
            else {
                let okAction = UIAlertAction(title: "ادامه", style:UIAlertActionStyle.Default) { (action) in
                }
                let alertController = UIAlertController(title: "", message:
                    "خطادر حذف حراج، دوباره تلاش کنید", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(okAction);
                self.presentViewController(alertController, animated: true, completion: nil);
            }
        };
    }
    
    

    
    
    
    func generateDiscountsObj () {
        
        // Validation
        // Start Date is not in the past
        var err=0;
        var errMsg="";
        
    
        var sYear = self.cellStartDate?.disDateYear.text;
        var sMonth:String! = self.cellStartDate?.disDateMonth.text as String!;
        var sDay:String! = self.cellStartDate?.disDateDay.text as String!;
        
        if (count(sMonth)<2) {
            sMonth = "0" + sMonth;
        }
        
        
        if (count(sDay)<2) {
            sDay = "0" + sDay;
        }
        
        var eYear = self.cellEndDate?.disDateYear.text;
        var eMonth = self.cellEndDate?.disDateMonth.text as String!;
        var eDay = self.cellEndDate?.disDateDay.text as String!;
        
        if (count(eMonth) < 2) {
            eMonth = "0" + eMonth;
        }
        
        if (count(eDay)<2) {
            eDay = "0" + eDay;
        }
        
        
        var startDateValidation = sYear! + sMonth! + sDay!;
        var endDateValidation = eYear! + eMonth! + eDay!;
        
        if (startDateValidation.toInt()==nil)
        {
            err = GlobalConstants.DISCOUNT_ADD_INVALID_DATE;
            errMsg = " تاریخ شروع حراج معتبر نیست" ;
        }
        
        if (endDateValidation.toInt()==nil)
        {
            err = GlobalConstants.DISCOUNT_ADD_INVALID_DATE;
            errMsg = " تاریخ پایان حراج معتبر نیست" ;
        }
      
        
        var startDate = "13" + sYear!+"/"+sMonth!+"/"+sDay!;
        var endDate = "13" + eYear!+"/"+eMonth!+"/"+eDay!;
        
        
        
        
        print ("Discount Manger: Start"+startDate);
        print ("Discount Manger: End"+endDate);
        
        // remove
        // startDate = "1394/01/12";
        // endDate = "1395/02/11";
        
        self.discount = DiscountModel(startDateStrFa: startDate, endDateStrFa: endDate, precentage: self.cellPrecentage?.percentage.text, note: self.cellNote?.note.text);
        
    }
    
    
    func validateForm () -> Bool{
        
        var err=0;
        var errMsg="";
        
        
        if (self.cellStartDate?.disDateYear.text.isEmpty == true ||
            self.cellStartDate?.disDateMonth.text.isEmpty == true ||
            self.cellStartDate?.disDateDay.text.isEmpty == true ||
            self.cellEndDate?.disDateYear.text.isEmpty == true ||
            self.cellEndDate?.disDateMonth.text.isEmpty == true ||
            self.cellEndDate?.disDateDay.text.isEmpty == true)
        {
            err = GlobalConstants.DISCOUNT_ADD_INCOMPLETE_DATE;
            errMsg = "لطفااطلاعات مرتبط با تاریخ حراج را وارد نمایید" ;
        }
        
        if (self.cellNote?.note.text.isEmpty == true &&
            self.cellPrecentage?.percentage.text.isEmpty == true) {
           
            err = GlobalConstants.DISCOUNT_ADD_DISCOUNT_DETAILS_REQUIRED;
            errMsg = "درصد تخفیف یا شرح تخفیف را وارد کنید" ;
        }
        
        if (err>0){
            let alertController = UIAlertController(title: "", message:errMsg, preferredStyle: UIAlertControllerStyle.Alert)
        
            let okAction = UIAlertAction(title: "ادامه", style:UIAlertActionStyle.Default) { (action) in
            }
            alertController.addAction(okAction);
            self.presentViewController(alertController, animated: true, completion: nil)
            return false;
        }
        
        return true;
       
    }
    
    
    
}
