//
//  ShopingAlertController.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit

final class ShopingController: BaseViewController {

    var orderDetail:Order = Order()
    private var countrys:[Country] = []

    @IBOutlet weak var txtEmail:UITextField!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var txtSurname:UITextField!
    @IBOutlet weak var txtPhone:UITextField!
    @IBOutlet weak var txtPostalCode:UITextField!
    @IBOutlet weak var txtCountry:UITextField!{
        didSet{
            self.txtCountry.inputView = pickerView
            txtCountry.inputAccessoryView = getToolBar()
        }
    }
    @IBOutlet weak var txtCity:UITextField!{
        didSet{
            self.txtCity.inputView = pickerView
            txtCity.inputAccessoryView = getToolBar()
        }
    }
    @IBOutlet weak var txtDistinc:UITextField!{
        didSet{
            self.txtDistinc.inputView = pickerView
            txtDistinc.inputAccessoryView = getToolBar()
        }
    }
    @IBOutlet weak var txtAdress:UITextView!

    let pickerView:UIPickerView = {
        let ll = UIPickerView()

        return ll
    }()
    var selectedCountryIndex = 0
    var selectedCityIndex = 0
    var selectedDistincIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.pickerWillOpen), name: UITextField.textDidBeginEditingNotification, object: nil)

        self.countrys = Country.gets()

        // Do any additional setup after loading the view.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func getToolBar()->UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
          toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Bitti", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.pickerDoneAppend))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolBar
    }
    @objc func pickerDoneAppend(){

        if txtCountry.isFirstResponder{

            self.orderDetail.country = self.countrys.count>selectedCountryIndex ? self.countrys[selectedCountryIndex].id : 0
            self.txtCountry.resignFirstResponder()
        }else if txtCity.isFirstResponder{
            self.orderDetail.city =   self.countrys[selectedCountryIndex].cities.count>selectedCityIndex ?   self.countrys[selectedCountryIndex].cities[selectedCityIndex].id : 0
            self.txtCity.resignFirstResponder()

        } else if txtDistinc.isFirstResponder{
            self.orderDetail.dist = self.countrys[selectedCountryIndex].cities[selectedCityIndex].distincs.count>selectedDistincIndex ?  self.countrys[selectedCountryIndex].cities[selectedCityIndex].distincs[selectedDistincIndex].id : 0
            self.txtDistinc.resignFirstResponder()

        }
    }
    @objc func pickerWillOpen(){
        self.pickerView.reloadAllComponents()
        if txtCountry.isFirstResponder{
            self.pickerView.selectRow(self.selectedCountryIndex, inComponent: 0, animated: false)
        }else if txtCity.isFirstResponder{
            self.pickerView.selectRow(self.selectedCityIndex, inComponent: 0, animated: false)
        } else if txtDistinc.isFirstResponder{
            self.pickerView.selectRow(self.selectedDistincIndex, inComponent: 0, animated: false)
        }
    }

    @IBAction func nextAppend(){
        self.view.endEditing(true)
        if checkTextFieldsIsNull(textFields: [txtName,txtEmail,txtPhone,txtSurname,txtPostalCode,txtPassword]) || txtAdress.text.count<=0 || self.orderDetail.city <= 0 || self.orderDetail.country <= 0 || self.orderDetail.dist <= 0{
            presentSingleActionAlert( message: "Lütfen Gerekli Alanları Doldurunuz")
            return
        }
        self.orderDetail.email = self.txtEmail.text!
        self.orderDetail.name = self.txtName.text!
        self.orderDetail.pass = self.txtPassword.text!
        self.orderDetail.surname = self.txtSurname.text!
        self.orderDetail.postalCode = self.txtPostalCode.text!
        self.orderDetail.phone = self.txtPhone.text!
        self.orderDetail.adress = self.txtAdress.text!

        let ll = OrderReviewResponse(order: self.orderDetail, products: CartProduct.getCartProducts(), countryN: self.countrys[selectedCountryIndex].name, cityN: self.countrys[selectedCountryIndex].cities[selectedCityIndex].name, distN: self.countrys[selectedCountryIndex].cities[selectedCityIndex].distincs[selectedDistincIndex].name)

        let vc:ReviewCartController = ReviewCartController.initlizeWithStoryBoard()
        vc.reviewResponse = ll
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension ShopingController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtCountry.isFirstResponder{
            return self.countrys.count
        }else if txtCity.isFirstResponder{
            return self.countrys[self.selectedCountryIndex].cities.count
        } else if txtDistinc.isFirstResponder{
            return self.countrys[self.selectedCountryIndex].cities[selectedCityIndex].distincs.count
        }

        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtCountry.isFirstResponder{
            return self.countrys[row].name
        }else if txtCity.isFirstResponder{
            return self.countrys[self.selectedCountryIndex].cities[row].name
        } else if txtDistinc.isFirstResponder{
            return self.countrys[self.selectedCountryIndex].cities[selectedCityIndex].distincs[row].name
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtCountry.isFirstResponder{
            self.selectedCountryIndex = row
            self.txtCountry.text = self.countrys[row].name
            self.selectedCityIndex = 0
            self.selectedDistincIndex = 0
            self.txtCity.text = nil
            self.txtDistinc.text = nil

        }else if txtCity.isFirstResponder{
            self.selectedCityIndex = row
            self.txtCity.text = self.countrys[self.selectedCountryIndex].cities[row].name
             self.selectedDistincIndex = 0
             self.txtDistinc.text = nil

        } else if txtDistinc.isFirstResponder{

            self.selectedDistincIndex = row
            self.txtDistinc.text = self.countrys[self.selectedCountryIndex].cities[selectedCityIndex].distincs[row].name

        }
    }

}
