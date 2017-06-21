//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Advait on 20/06/17.
//  Copyright © 2017 Advait. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var userCityInput: UITextField!
    
    @IBOutlet weak var resultLabelText: UILabel!
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        
        var message1 = " "

        
        
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + userCityInput.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data,response,error in
            
            
            
            if error != nil
            {
                print(error as Any)
            }
            else{
                if let unwrappedData = data{
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator){
                        
                        if contentArray.count > 1{
                            stringSeparator = "</span>"
                            let resultArray  = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if resultArray.count>1{
                                
                                message1 = resultArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(message1)
                            }
                            
                        }
                    }
                }
            }
            if message1 ==  " "{
                message1 = "The weather there could not be found. Please try again"
            }
            DispatchQueue.main.sync(execute: {
                self.resultLabelText.text = message1
            })
            
        }
        
        task.resume()
        }
        else{
            resultLabelText.text = "The weather there could not be found. Please try again"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabelText.text = " "
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

