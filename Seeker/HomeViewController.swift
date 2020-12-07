//
//  HomeViewController.swift
//  Seeker
//
//  Created by user178654 on 12/5/20.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet  var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsData.count
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! itemCell
            
            cell.imageView =
                UIImageView(image: UIImage(named:  newsData[indexPath.row].imageName))
            cell.label.text = newsData[indexPath.row].title
            cell.source.text = newsData[indexPath.row].link
            print(newsData[indexPath.row].imageName)
            return cell
    }
}


