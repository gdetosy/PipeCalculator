//
//  Manager.swift
//  PipeCalculator
//
//  Created by tosy on 30.01.23.
//

import Foundation
import UIKit

let calendar = Calendar.current
var date = Date()
let day = calendar.dateComponents([.day], from: date).day!
let month = calendar.dateComponents([.month], from: date).month!
func string() -> String {
    let url = "http://numbersapi.com/\(month)/\(day)/date?json"
    let calendar = Calendar.current
    let date = Date()
    let day = calendar.dateComponents([.day], from: date).day!
    let month = calendar.dateComponents([.month], from: date).month!
    print(day)
    print(date)
    print(url)
    print(month)
    return url
}

struct Url {
    let url = "https://www.nbrb.by/api/exrates/rates?periodicity=0"
}

struct Currency {
    var diametr: Float = 0
    var tolshina: Float = 0
    var dlina: Float = 0
    var height: Float = 0
    var usd: String = ""
    var eur: String = ""
    var finishPrice: Float = 0
    var segmentos = 0
}

protocol alert {
    func alert()
    func alert1()
    
}

extension MainViewController: alert {
    func alert() {
        let alert = UIAlertController(title: "Сalculation formula", message: "ТThe pipe calculator calculates the weight of a round electric-welded pipe using the formula:                                      Pipe weight = ((pipe diameter - wall thickness) x wall thickness x 0.02466 x footage) / 1000",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func alert1() {
        let alert = UIAlertController(title: "calculation formula", message: "The pipe calculator calculates the weight of a round electric-welded pipe using the formula:                                     Pipe length = mass * 1000 / ((pipe diameter - wall thickness) * 0.0246 * wall thickness)",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

enum Qoute: String, CaseIterable {
    case one = "Don't let the noise of others' opinions drown out your own inner voice."
    case two = "Have the courage to follow your heart and intuition."
    case three = "I would trade all of my technology for an afternoon with Socrates."
    case four = "If you haven't found it yet, keep looking."
    case five = "Innovation distinguishes between a leader and a follower."
    case six = "Some people aren't used to an environment where excellence is expected."
    case seven = "Sometimes life's going to hit you in the head with a brick."
    case eight = "Stay hungry, stay foolish."
    case nine = "Things don't have to change the world to be important."
    case ten = "Why join the navy if you can be a pirate?"
    case eleven = "You have to trust in something - your gut, destiny, life, karma, whatever."
    case twelve = "Your time is limited, so don't waste it living someone else's life."
}
 
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
