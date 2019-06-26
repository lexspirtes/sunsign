//
//  VC2.swift
//  reactiveHoroscope
//
//  Created by Alexandra Spirtes on 6/25/19.
//  Copyright © 2019 Alexandra Spirtes. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ReactiveSwift
import ReactiveCocoa

class VC2: UIViewController {
    var viewModel: viewModel2
    
    init(viewModel: viewModel2) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    func makeConstraints() {
        //testfield
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(view).offset(-120)
            make.centerX.equalTo(view)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.reactive.text <~ viewModel.greeting
        view.addSubview(nameLabel)
        makeConstraints()
        view.backgroundColor = .white
        
    }
}
