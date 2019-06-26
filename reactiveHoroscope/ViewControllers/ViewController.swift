//
//  ViewController.swift
//  reactiveHoroscope
//
//  Created by Alexandra Spirtes on 6/19/19.
//  Copyright © 2019 Alexandra Spirtes. All rights reserved.
//
import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import SnapKit
import Result

class VC1: UIViewController, UITextFieldDelegate {
    var viewModel: HoroscopeViewModel
    
    let nextButton: UIButton = {
        let myString = "get my sign"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7)
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.customColors.tangerine.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
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
        
        //dateLabel
        dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(datePicker.snp.top).offset(-12)
            make.left.equalTo(view.safeAreaInsets).offset(48)
        }
        
        //datePicker
        datePicker.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(60)
        }
        
        //nextButton
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.datePicker.snp.bottom).offset(32)
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
        view.addSubview(nextButton)
        view.addSubview(dateLabel)
        makeConstraints()
        self.navigationItem.title = "what's my sign again"
        self.nextButton.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.tapButton() }
        viewModel.buttonSignal.observeValues(self.navigateToNextView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func navigateToNextView() {
        let outputViewModel = self.viewModel.getOutputViewModel()
        let outputView = VC2(viewModel: outputViewModel)
        self.navigationController?.pushViewController(outputView, animated: true)

    }
    
    init(viewModel: HoroscopeViewModel) {
        self.viewModel = viewModel
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

