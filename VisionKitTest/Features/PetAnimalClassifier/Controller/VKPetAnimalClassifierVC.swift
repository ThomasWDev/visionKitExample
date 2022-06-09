//
//  VKPetAnimalClassifierVC.swift
//  VisionKitTest
//
//  Created by Thomas Woodfin on 6/9/22.
//

import UIKit
import Vision

class VKPetAnimalClassifierVC: UIViewController{
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var takePictureBtn: UIButton!
    
    private var animalRecognitionRequest = VNRecognizeAnimalsRequest(completionHandler: nil)
    
    private let animalRecognitionWorkQueue = DispatchQueue(label: "PetClassifierRequest", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setupVision()
    }
    
    private func setStyle(){
        title = "Pet Animal Classifier"
        textView.isEditable = false
        imageView.image = UIImage(systemName: "photo")
        takePictureBtn.layer.borderWidth = 1
        takePictureBtn.layer.borderColor = UIColor.gray.cgColor
        takePictureBtn.layer.cornerRadius = 8
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setupVision() {
        animalRecognitionRequest = VNRecognizeAnimalsRequest { (request, error) in
            DispatchQueue.main.async {
                if let results = request.results as? [VNRecognizedObjectObservation] {
                    var detectionString = ""
                    var animalCount = 0
                    for result in results
                    {
                        let animals = result.labels
                        
                        for animal in animals {
                            
                            animalCount = animalCount + 1
                            var animalLabel = ""
                            
                            if animal.identifier == "Cat"{
                                animalLabel = "😸"
                            }
                            else{
                                animalLabel = "🐶"
                            }
                            
                            let string = "#\(animalCount) \(animal.identifier) \(animalLabel) confidence is \(animal.confidence)\n"
                            detectionString = detectionString + string
                        }
                    }
                    
                    if detectionString.isEmpty{
                        detectionString = "Neither cat nor dog"
                    }
                    self.textView.text = detectionString
                }
            }
        }
    }
    
    private func processImage(_ image: UIImage) {
        imageView.image = image
        animalClassifier(image)
    }
    
    private func animalClassifier(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        textView.text = ""
        animalRecognitionWorkQueue.async {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([self.animalRecognitionRequest])
            } catch {
                print(error)
            }
        }
    }
}

extension VKPetAnimalClassifierVC: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.imageView.image = image
                self.processImage(image)
                
            }
        }
    }
}


