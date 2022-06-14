//
//  ViewController.swift
//  MultithreadingApp
//
//  Created by Pritam Dash on 14/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelDate : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //AS soon as screen appears the function gets called.
        let thread = TimerThread()
        thread.viewController = self
        thread.start() //here thread starts and gets scheduled on cpu and main() runs
    }
    
//    func showTimer() -> Void {
//        while true{
//            let d = Date()
//            let formatter : DateFormatter = DateFormatter()
//            let strFormat = "dd-MM-YYYY hh:mm:ss"
//            //dd - day, MM - month, YYYY - year, hh : hour, mm : minutes, ss : seconds
//            formatter.dateFormat = strFormat
//            //DateFormatter.string(from:date) returns a string
//            labelDate.text = formatter.string(from: d)
//
//            //Let's give a delay of 1 second.
//            Thread.sleep(forTimeInterval: 1)
//            print(Thread.current)   //printing in console
//            // o/p : <_NSMainThread: 0x6000029e4000>{number = 1, name = main}
//            //by doing Thread.sleep(forTimeInterval: 1) the UI doesnot get updated at all, becuse the refreshing of the screen, UI handling happens on the main thread and you are making the main thread sleep again and again at 1 sec delay.
//            //As UI is not active with main thread asleep, app screen freezes.
//            //So you need to do the sleep part in child thread.
//        }
//   }

}
class TimerThread : Thread {
    var viewController : ViewController!
    override func main() {
        while true{
            let d = Date()
            let formatter : DateFormatter = DateFormatter()
            let strFormat = "dd-MM-YYYY hh:mm:ss"
            //dd - day, MM - month, YYYY - year, hh : hour, mm : minutes, ss : seconds
            formatter.dateFormat = strFormat
            //DateFormatter.string(from:date) returns a string
            //viewController.labelDate.text = formatter.string(from: d)
            //special error/sugggestion : UILabel.text must be used from main thread only
            //All the UI elements run on main thread but we are updating the ui label in child thread.
            
            let queue = DispatchQueue.main
            //DispatchQueue - class name, main - The dispatch queue associated with the main thread of the current process
            let myClosure = {
                () -> Void in
                self.viewController.labelDate.text = formatter.string(from: d)
                //have to add "self"
            }
            queue.async(execute: myClosure)
            
            //Let's give a delay of 1 second.
            Thread.sleep(forTimeInterval: 1)
            print(Thread.current)   //printing in console
            //O/p : <MultithreadingApp.TimerThread: 0x6000010d6c10>{number = 7, name = (null)}
            //Here the new child thread will sleep not the main thread.
        }
    }
}
/*
 NOTE :
 GCD : Grand Central Dispatch
 Whatever data you want to pass from 1 thread to another you can easily do that but have to follow procedure :
        Create a code and pass it to the next thread from the current thread to get executed.
        Thread executed by OS, has threadNumber.
    Here the concept of DispatchQueue comes to play.
    Every thread can have an extra queue known as dispatchQueue where it can recieve and hold "code blocks" sent from other thread.
    So when OS recieves the new threads number it will also execute the new thread's dispatchQueue.
 
 Main thread by default has a dispatchQueue attached to it.

 */
