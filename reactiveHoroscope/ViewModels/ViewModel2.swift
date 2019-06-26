//
//  ViewModel2.swift
//  reactiveHoroscope
//
//  Created by Alexandra Spirtes on 6/25/19.
//  Copyright © 2019 Alexandra Spirtes. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa

class viewModel2 {
    let sign: Property<String>
    let greeting: Property<String>
    
    class func dateToInt(birthday: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        let selectedDate = dateFormatter.string(from: birthday)
        let intDate = Int(selectedDate) ?? 0
        return intDate
    }
    
    class func calculateSign(date: Int) -> String {
        switch date {
        case 321...419:
            return "Aries"
        case 420...520:
            return "Taurus"
        case 521...620:
            return "Gemini"
        case 621...722:
            return "Cancer"
        case 723...822:
            return "Leo"
        case 823...922:
            return "Virgo"
        case 923...1022:
            return "Libra"
        case 1023...1121:
            return "Scorpio"
        case 1122...1221:
            return "Sagittarius"
        case 1222...1300:
            return "Capricorn"
        case 0...119:
            return "Capricorn"
        case 120...218:
            return "Aquarius"
        case 219...420:
            return "Pisces"
        default:
            return "No Birthday has been inputted!"
        }
    }
    
    class func makeGreeting(name: String, sign: String) -> String {
        let myString: String
        if name == "" {
            myString = """
            Oh fuck.
            You gotta put your name in!
            """
        }
        else {
            myString =
            """
            \(name),
            you are a total
            \(sign)
            """
        }
        return myString
        
    }
    
    init(name: MutableProperty<String>, date: MutableProperty<Date>){
        //everytime date gets set in mutable property going to transform
        self.sign = date.map { date in
            return viewModel2.calculateSign(date: viewModel2.dateToInt(birthday: date))
        }
        self.greeting = self.sign.map { sign in
            return viewModel2.makeGreeting(name: name.value, sign: sign)
        }
    }
    
}
