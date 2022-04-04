//
//  ViewController.swift
//  TextRecognition
//
//  Created by a-robot on 4/3/22.
//

import UIKit
import Vision


class ViewController: UIViewController {

    private let label: UILabel = { // --> assignment for all the code below.
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "first")
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
        recognizeText(imagre: imageView.image)
    }
    
    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x : 20,
        y: view.safeAreaInsets.top,
        width: view.frame.size.width-40,
            height:view.frame.size.height-40
        //height:200
        )
    }

    
    
    private func recognizeText(imagre: UIImage?) {
        guard let cgImage = image?.CGImage else { return } // --  TRY TO GET IMAGE
        
 
    // HANDLER
        
        let handler = VNImageRequestHandler(CGImage: CGImage as! CGImage, options: [:])
    
    
    // REQUEST --> set error and reqeust.. cast as VNRecogniedTextObservation
        let request = VNDetectRectanglesRequest{ [weak self ] request,
            error in guard
                let observerations = results.results as? [VNRecogniedTextObservation],
                    error == nil else {
                return
            }
            // Text, if request works build string
            let text = observerations.compactMap({
                $0.topCandidates(1).first?.string}).joined(seperateor: ",") //[INPLACE INCASE UI RETURNS MULTIPEL STRINGS]
            DispatchQueue.main.async {
                self?.label.text
            }
        };
        request.results as?[VNRecognizedTextObservation]
            
        do { // [ERROR HANDLING][
            try handler.perform([request])
            
        }
        catch {
            print(error)
        }
    
    // PROCESS AND REQUEST

    }


