//
//  PageWay.swift
//  reactiveHoroscope
//
//  Created by Alexandra Spirtes on 6/20/19.
//  Copyright © 2019 Alexandra Spirtes. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import SnapKit
import Result

//reactive bindings provide signals

class page1VC: UIViewController, UITextFieldDelegate {
    var viewModel: HoroscopeViewModel!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        let myText = "name"
        // label.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 25)
        let attributes: NSDictionary = [
            NSAttributedString.Key.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 20),
            NSAttributedString.Key.kern: CGFloat(1.0)]
        let attributedTitle = NSAttributedString(string: myText, attributes:attributes as? [NSAttributedString.Key : AnyObject])
        label.attributedText = attributedTitle
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        let myText = "birthday"
        // label.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 25)
        let attributes: NSDictionary = [
            NSAttributedString.Key.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 20),
            NSAttributedString.Key.kern: CGFloat(1.0)]
        let attributedTitle = NSAttributedString(string: myText, attributes:attributes as? [NSAttributedString.Key : AnyObject])
        label.attributedText = attributedTitle
        return label
    }()
    
    let textField:UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 15)
        field.placeholder = "your name plz"
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.borderStyle = UITextField.BorderStyle.roundedRect
        return field
    }()
    
    let datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePicker.Mode.date
        return datePicker
    }()
    
    func makeConstraints() {
        //testfield
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(12)
            make.left.equalTo(self.nameLabel)
            make.right.equalTo(self.view.safeAreaInsets).offset(-48)
        }
        
        //nameLabel
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaInsets).offset(64)
            make.left.equalTo(view.safeAreaInsets).offset(48)
        }
        
        //nameLabel
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(96)
            make.left.equalTo(view.safeAreaInsets).offset(48)
        }
        
        //datePicker
        datePicker.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        viewModel.name <~ textField.reactive.continuousTextValues
        viewModel.date <~ datePicker.reactive.dates
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(textField)
        view.addSubview(datePicker)
        view.addSubview(dateLabel)
        makeConstraints()
        self.navigationItem.title = "what's my sign again"

        // Do any additional setup after loading the view.
    }
    
    func navigateToNextView() -> UIViewController {
        print("navigate")
        let outputViewModel = viewModel.getOutputViewModel()
        let outputView = VC2(viewModel: outputViewModel)
        return outputView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    init(viewModel: HoroscopeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

