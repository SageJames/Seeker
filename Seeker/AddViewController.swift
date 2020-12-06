//
//  AddViewController.swift
//  Seeker
//
//  Created by user178654 on 12/6/20.
//

import UIKit
import CoreML
import Vision


class AddViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        let imagePath = Bundle.main.path(forResource: "mask", ofType: "jpg")
        let imageUrl = NSURL.fileURL(withPath: imagePath!)
        let modelFile = Mask3_1()
        let model = try! VNCoreMLModel(for: modelFile.model)
        let handler = VNImageRequestHandler(url: imageUrl)
        let request = VNCoreMLRequest(model: model, completionHandler: findResults)
        try! handler.perform([request])
        }
    func findResults(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNRecognizedObjectObservation] else {
                    fatalError("Unable to get results")
                }

                var bestGuess = ""
                var bestConfidence: VNConfidence = 0

                for classification in results {
                    if (classification.confidence > bestConfidence) {
                        bestConfidence = classification.confidence
                        bestGuess = classification.labels.first!.identifier
                    }
                }

                labelDescription.text = "They are \(bestGuess) with confidence \(bestConfidence) out of 1"
            }

}
