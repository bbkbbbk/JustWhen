//for future improvement

import UIKit
import UserNotifications

class ViewController: UIViewController {

    var year = Calendar.current.component(.year, from: Date())
    var month = Calendar.current.component(.month, from: Date())
    var day = Calendar.current.component(.day, from: Date())
    var hour = Float(Calendar.current.component(.hour, from: Date()))
    var min = Float(Calendar.current.component(.minute, from: Date()))
    var weekday = Calendar.current.component(.weekday, from: Date())
    var timer = Timer()

    @IBOutlet weak var weekendBg: UIView!
    @IBOutlet weak var congrats: UIImageView!
    @IBOutlet weak var Monday: UIView!
    @IBOutlet weak var Tuesday: UIView!
    @IBOutlet weak var Wednesday: UIView!
    @IBOutlet weak var Thursday: UIView!
    @IBOutlet weak var Friday: UIView!
    @IBOutlet weak var MonPro: UIProgressView!
    @IBOutlet weak var MorPro: UIProgressView!
    @IBOutlet weak var EvePro: UIProgressView!


    override func viewDidLoad() {
        super.viewDidLoad()

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

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }

    @objc func update(){
        weekday = Calendar.current.component(.weekday, from: Date())
        hour = Float(Calendar.current.component(.hour, from: Date()))
        min = Float(Calendar.current.component(.minute, from: Date()))
        MonPro.progress = calTime(9.0, hour, min)
        MorPro.progress = calTime(9.0, hour, min)
        EvePro.progress = calTime(13.0, hour, min)

        Monday.isHidden = true
        Tuesday.isHidden = true
        Wednesday.isHidden = true
        Thursday.isHidden = true
        Friday.isHidden = true
        weekendBg.isHidden = true

        if weekday == 2 {
            //            self.content.title = "Yey, Today you have only 1 class!"
            //            self.content.body = "English 9:00 - 12:00 @IC03"
            Monday.isHidden = false
            MorPro.isHidden = true
            EvePro.isHidden = true
        } else if weekday == 3 {
            //            self.content.title = "Today you have 2 to go"
            //            self.content.body = "Discrete Math 9:00 - 12:00 @IC06 and Philosophy of Sci 13:00 - 16:00 @IC06"
            Tuesday.isHidden = false
            MorPro.isHidden = false
            EvePro.isHidden = false
        } else if weekday == 4 {
            //            self.content.title = "Today you have 2 to go but it's a half way!"
            //            self.content.body = "Philosophy of Sci 9:00 - 12:00 @IC06 and Digital Circuit 13:00 - 16:00 @IC04"
            Wednesday.isHidden = false
            MorPro.isHidden = false
            EvePro.isHidden = false
        } else if weekday == 5 {
            //            self.content.title = "Hold on, it's 2 classes but only a day left"
            //            self.content.body = "OOP 9:00 - 12:00 @IC06 and Digital Circuit Lab 13:00 - 16:00 @IC16"
            Thursday.isHidden = false
            MorPro.isHidden = false
            EvePro.isHidden = false
        } else if weekday == 6 {
//                        self.content.title = "Thanks God it's Friday!!!"
//                        self.content.body = "OOP Lab 9:00 - 12:00 @IC01, IC16 and Calculus 2 13:00 - 16:00 @IC04"
            Friday.isHidden = false
            MorPro.isHidden = false
            EvePro.isHidden = false
            Friday.backgroundColor = .black
        } else {
            //            content.title = "OMG It's weekend!!!!!"
            //            content.body = "Let you sleep in peace!"
            weekendBg.isHidden = false
            MorPro.isHidden = true
            EvePro.isHidden = true
            UIView.animate(withDuration: 4) {
                self.congrats.frame = CGRect(x: 70, y: 220, width: 240, height: 361)
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

