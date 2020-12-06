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
    
    var dueDate = "Unknown"
    var dueState = "Unknown"
    var duePos = "Unknown"
    var dueTot = "Unknown"
    var dueTCL = "Unknown"
    var dueInc = "Unknown"
    var dueHash = "Unknown"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
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
                              let num = dictionary["positive"] as? Int
                              let dat = dictionary["date"] as? Int
                              let arrayDat = Array(String(dat!))
                              let month = "\(arrayDat[4])" + "\(arrayDat[5])"
                              let day = "\(arrayDat[6])" + "\(arrayDat[7])"
                              let year = "\(arrayDat[0])"+"\(arrayDat[1])"+"\(arrayDat[2])"+"\(arrayDat[3])"
                              let fullDate = "\(month)" + "\\" + "\(day)" + "\\" + "\(year)"
                            let state = "\(String(describing: dictionary["state"]))"
                            let pos =  "\(String(describing: num))"
                            let deaths = "\(String(describing: dictionary["death"]))"
                            let total = "\(String(describing: dictionary["total"]))"
                            let increase  = "\(String(describing: dictionary["positiveIncrease"]))"
                            let hash  = "\(String(describing: dictionary["hash"]))"
                
                            //Setting the values
                        
                          
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

    }
        
        func handleServerError(response: URLResponse) {
            print(response)
        }
        func handleClientError(error: Error) {
            print(error)
        }


}
