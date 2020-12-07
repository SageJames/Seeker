//
//  HomeViewController.swift
//  Seeker
//
//  Created by user178654 on 12/5/20.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate{
 
    @IBOutlet weak var table: UITableView!
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        cell?.textLabel?.text =
            newsData[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = "\(newsData[indexPath.row].link)"
        let alert = UIAlertController(title: "Opening", message: "\(selectedItem)", preferredStyle: .alert)
        let canelAction = UIAlertAction(title: "cancel", style: .default, handler: {action -> Void in
                   //diss
               })
        alert.addAction(canelAction)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action -> Void in
            UIApplication.shared.open(URL.init(string: newsData[indexPath.row].link)!, options: [:], completionHandler: nil)
            
        })
               alert.addAction(okAction)
               self.present(alert, animated: true, completion: nil)
    }
    
    
    
            
     //       cell.imageView =
    //         UIImageView(image: UIImage(named:  newsData[indexPath.row].imageName))
         //   cell.label.text = newsData
           // print(newsData[indexPath.row].imageName)
      //      return cell
    //}
}


