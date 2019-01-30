//
//  JustWhenViewViewController.swift
//  JustWhen
//
//  Created by home on 4/1/2562 BE.
//  Copyright © 2562 bbkbbbk. All rights reserved.
//

import UIKit
import UserNotifications

class JustWhenViewViewController: UIViewController {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var morPro: UIProgressView!
    @IBOutlet weak var course2: UILabel!
    @IBOutlet weak var evePro: UIProgressView!
    @IBOutlet weak var congrats: UIImageView!
    
    var year = Calendar.current.component(.year, from: Date())
    var month = Calendar.current.component(.month, from: Date())
    var day = Calendar.current.component(.day, from: Date())
    var hour = Float(Calendar.current.component(.hour, from: Date()))
    var min = Float(Calendar.current.component(.minute, from: Date()))
    var weekday = Calendar.current.component(.weekday, from: Date())
    var timer = Timer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        date.isHidden = true
//        course.isHidden = true
//        course2.isHidden = true
//        morPro.isHidden = true
//        evePro.isHidden = true
        let content = UNMutableNotificationContent()
        content.title = "BE PREPARED"
        content.body = "Better finish everything"
        content.sound = UNNotificationSound.default
        
        let content2 = UNMutableNotificationContent()
        content2.title = "Hurry!!!"
        content2.body = "Bookie You Must Leave Home Now!!!"
        content2.sound = UNNotificationSound.default
        
        var dateCom = DateComponents()
        dateCom.hour = 7
        dateCom.minute = 20
        
        var dateCom2 = DateComponents()
        dateCom2.hour = 7
        dateCom2.minute = 35
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCom, repeats: true)
        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateCom2, repeats: true)
        let request2 = UNNotificationRequest(identifier: "TestIdentifier2", content: content2, trigger: trigger2)
        UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update(){
        weekday = Calendar.current.component(.weekday, from: Date())
        hour = Float(Calendar.current.component(.hour, from: Date()))
        min = Float(Calendar.current.component(.minute, from: Date()))
        morPro.progress = calTime(9.0, hour, min)
        evePro.progress = calTime(13.0, hour, min)
        
        date.isHidden = false
        course.isHidden = false
        course2.isHidden = false
        morPro.isHidden = false
        evePro.isHidden = false
        
        if weekday == 2 {
            course.isHidden = true
            view.backgroundColor = UIColor(red: 243.0/255.0, green: 201.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            course.frame.origin = CGPoint(x: course.frame.origin.x, y: 310)
            course.isHidden = false
            congrats.frame.origin = CGPoint(x: congrats.frame.origin.x, y: 813)
            morPro.frame.origin = CGPoint(x: 34, y: 450)
            date.text = "Monday"
            course.text = "English\n9:00 - 12:00\nIC03"
            course2.isHidden = true
            evePro.isHidden = true
        } else if weekday == 3 {
            view.backgroundColor = UIColor(red: 224/255.0, green: 126/255.0, blue: 138/255.0, alpha: 1.0)
            date.text = "Tuesday"
            course.text = "Discrete Math\n9:00 - 12:00\nIC06"
            course2.text = "Philosophy of Science\n13:00 - 16:00\nIC06"
        } else if weekday == 4 {
            view.backgroundColor = UIColor(red: 65/255.0, green: 147/255.0, blue: 137/255.0, alpha: 1.0)
            date.text = "Wednesday"
            course.text = "Philosophy if Science\n9:00 - 12:00\nIC06"
            course2.text = "Digital Circuit\n13:00 - 16:00\nIC06"
        } else if weekday == 5 {
            view.backgroundColor = UIColor(red: 237/255.0, green: 108/255.0, blue: 83/255.0, alpha: 1.0)
            date.text = "Thursday"
            course.text = "OOP\n9:00 - 12:00\nIC06"
            course2.text = "Digital Circuit Lab\n13:00 - 16:00\nIC16"
        } else if weekday == 6 {
            view.backgroundColor = UIColor(red: 102/255.0, green: 136/255.0, blue: 247/255.0, alpha: 1.0)
            date.text = "Friday"
            course.text = "OOP Lab\n9:00 - 12:00\nIC01, IC16"
            course2.text = "Calculus 2\n13:00 - 16:00\nIC04"
        } else {
            view.backgroundColor = UIColor(red: 46/255.0, green: 56/255.0, blue: 70/255.0, alpha: 1.0)
            date.isHidden = true
            course.isHidden = true
            course2.isHidden = true
            morPro.isHidden = true
            evePro.isHidden = true

            UIView.animate(withDuration: 5) {
                self.congrats.frame = CGRect(x: self.congrats.frame.origin.x, y: 200, width: 270, height: 321)
            }
        }
    }
    
    func calTime(_ startTime: Float, _ hour: Float, _ min: Float) -> Float {
        if startTime <= hour && hour <= startTime + 3 {
            return (((hour - startTime) * 60) + min)/180
        } else if hour > startTime + 3 {
            return 1
        }
        return 0
    }
}
