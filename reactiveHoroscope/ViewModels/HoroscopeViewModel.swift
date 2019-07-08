//
//  HoroscopeViewModel.swift
//  reactiveHoroscope
//
//  Created by Alexandra Spirtes on 6/25/19.
//  Copyright © 2019 Alexandra Spirtes. All rights reserved.
//


import Result
import ReactiveCocoa
import ReactiveSwift

class HoroscopeViewModel {
    
    let date: MutableProperty<Date>
    let name: MutableProperty<String>
    let (buttonSignal, buttonTapped) = Signal<(), NoError>.pipe()
    
    init(){
        self.name = MutableProperty("")
        self.date = MutableProperty(Date())
    }
    
    var navigateSignal: Signal<(), NoError> {
        //zipping properties together, waiting for signal to come through both of them
        //turn into signal
        //map because signal doesn't care about extra information, return type ()
        return self.date.zip(with: self.name)
            .signal
            .map { _ in () }
    }
    
    var combined: Signal<(), NoError> {
        return Signal.combineLatest(self.dateSignal, self.nameSignal)
            .map { _ in () }
    }
    
    //combine latest --> sort of like an or
    //merge two signals of same type and interweave them
    
    var dateSignal: Signal<(), NoError> {
        return self.date
            .signal
            .map { _ in ()}
    }
    
    var nameSignal: Signal<(), NoError> {
        return self.name
            .signal
            .map { _ in () }
    }
    
    func tapButton() {
        self.buttonTapped.send(value: ())
    }
    
    func getOutputViewModel() -> viewModel2 {
        return viewModel2(name: self.name, date: self.date)
    }
}
