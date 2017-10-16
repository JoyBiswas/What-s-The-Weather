//
//  ViewController.swift
//  What's The Wheather
//
//  Created by MacBook Air on 10/15/17.
//  Copyright © 2017 MacBook Air. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityEntryTextField: UITextField!
    
    @IBOutlet weak var cityOutputTextField: UILabel!
    
    
    @IBOutlet weak var resultOutPutlabel: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }

    
    @IBAction func submittPressed(_ sender: Any) {
        
        if  let url = URL(string: "http://www.weather-forecast.com/locations/"+cityEntryTextField.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data,response,error in
            
            var message = ""
            
            if error != nil {
                
                print(error!)
            }else {
                
              if  let unWrappedData = data {
                    
                    let dataString = NSString(data: unWrappedData , encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
            print(stringSeperator)
                
                    if let contentArray = dataString?.components(separatedBy: stringSeperator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeperator = "</span>"
                            
                            let newContentarray = contentArray[1].components(separatedBy: stringSeperator)
                            
                            if newContentarray.count > 1 {
                                
                                let fressMessage = newContentarray[0].replacingOccurrences(of: ";", with: "")
                                
                                message = fressMessage.replacingOccurrences(of: "&deg", with: "°")
                                
                                print(message)
                            }
                            
                            
                        }
                        
                    }
                    
                }
            }
            if message == "" {
                
                message = "The Wheather there Couldn't found.Please Try again !"  }
            
            DispatchQueue.main.sync(execute: {
                
                self.resultOutPutlabel.text = message
                
            })
            
            
        }
        task.resume()
        
        } else {
            resultOutPutlabel.text = "The Wheather there Couldn't found.Please Try again !"
        }
        
        cityOutputTextField.text = cityEntryTextField.text
        
        cityEntryTextField.text = ""
        
        
        
    }
    
    

}

