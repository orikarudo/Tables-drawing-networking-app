//
//  Drawing.swift
//  Project 4
//
//  Created by Ori Karudo on 8/15/19.
//  Copyright © 2019 Ori Karudo. All rights reserved.
//

import UIKit

class Drawing: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(2.0)
        context!.setStrokeColor(UIColor.blue.cgColor)
        
        //making path
        let m = Double(mLabel.text!)
        let b = Double(bLabel.text!)
        var temp1 = m!*0 + b!
        temp1 = 500 - temp1
        var temp2 = m!*600 + b!
        temp2 = 500 - temp2
        context!.move(to: CGPoint(x: 0, y: temp1))
        context!.addLine(to: CGPoint(x: 600, y:temp2))
        
        
        //color in
        context!.strokePath()
    }
 
    @IBOutlet weak var mLabel: UILabel!
    @IBAction func mSlider(_ sender: UISlider) {
        mLabel.text = String(Double(sender.value))
        setNeedsDisplay()
    }
    
    @IBOutlet weak var bLabel: UILabel!
    @IBAction func bSlider(_ sender: UISlider) {
        bLabel.text = String(Double(sender.value))
        setNeedsDisplay()
    }
    
    
    @IBAction func doubleWeb(_ sender: Any) {
        
        let myUrl = URL(string: "https://cs.binghamton.edu/~pmadden/php/double.php")!
        
        var request = URLRequest(url: myUrl)
        
        request.httpMethod = "POST"
        let m = mLabel.text!
        
        let sendString = "value=" + m
        print(sendString)
        request.httpBody = sendString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    // Now we can access value of First Name by its key
                    let newVal = parseJSON["value"] as? String
                    print("new value: \(newVal)")
                    self.mLabel.text = newVal
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        setNeedsDisplay()
    }
    
}
