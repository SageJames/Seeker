//
//  LogViewController.swift
//  Seeker
//
//  Created by user178654 on 12/5/20.
//

import UIKit

class LogViewController: UIViewController {
    var covidData : [String]? = nil
    let session = URLSession.shared
    let url = URL(string: "https://api.covidtracking.com/v1/states/nc/daily.json")!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var positiveCaseLabel: UILabel!
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var increasedRateLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
            let task = self.session.dataTask(with: self.url, completionHandler: { [self] data, response, error in
                   if error != nil {
                       self.handleClientError(error: error!)
                       return
                   }
                  guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
                   else {
                       self.handleServerError(response: response!)
                       return
                   }
                   guard let mime = response?.mimeType, mime == "application/json"
                    else {
                       print("Wrong MIME type!")
                       return
                   }
              do {
                  let json = try JSONSerialization.jsonObject(with: data!, options: [])
                  self.covidData = []
                  if let covidDataArray = json as? [Any] {
                      let object = covidDataArray[0]
                          if let dictionary = object as? [String: Any] {
                              let dat = dictionary["date"] as? Int
                              let arrayDat = Array(String(dat!))
                              let month = "\(arrayDat[4])" + "\(arrayDat[5])"
                              let day = "\(arrayDat[6])" + "\(arrayDat[7])"
                              let year = "\(arrayDat[0])"+"\(arrayDat[1])"+"\(arrayDat[2])"+"\(arrayDat[3])"
                              let fullDate = "\(month)" + "\\" + "\(day)" + "\\" + "\(year)"
                            let state = "\(dictionary["state"]!)"
                            let pos =  "\(String((dictionary["positive"] as? Int)!))"
                            //let deaths = "\(String(describing: dictionary["death"]))"
                            let total = "\(String((dictionary["total"] as? Int)!))"
                            let increase  = "\(String((dictionary["positiveIncrease"] as? Int)!))"
                            let hash  = "\(dictionary["hash"]!)"
                
                            print(dictionary["hash"]!)
                            //Setting the values
                            DispatchQueue.main.async {
                                self.dateLabel.text = fullDate
                                self.stateLabel.text = state
                                self.positiveCaseLabel.text = pos
                                self.totalCaseLabel.text = total
                                self.increasedRateLabel.text = increase
                                self.hashLabel.text = hash
                            }
                        
                          
                          }    }
                
              } catch {
                  print("JSON error: \(error.localizedDescription)")
              }
            
            })
            
            task.resume()
            
            while (self.covidData == nil) {
                usleep(500)
            }
        

        
    }
   
        
        func handleServerError(response: URLResponse) {
            print(response)
        }
        func handleClientError(error: Error) {
            print(error)
        }


}
