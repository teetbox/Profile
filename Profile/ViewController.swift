//
//  ViewController.swift
//  Profile
//
//  Created by Tong Tian on 9/29/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addProfile(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    
    @IBAction func downloadProfile(_ sender: Any) {
        let endPoint = "https://efbplus.ceair.com:600/hwappcms/file/app/623010657006.png"
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data)
                    print(data.count)
                }
            }
        }
        
        task.resume()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = pickedImage
            profileImageView.contentMode = .scaleAspectFit
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func uploadProfile(_ image: UIImage) {
        let resizedImage = image.resize(with: 100)
        
        let imageData = UIImagePNGRepresentation(resizedImage)
        
        let url = "https://efbplus.ceair.com:600/hwappcms/etp/fileUpload/uploadIcon"
        
    }
    
}

extension UIImage {
    
    func resize(with width: CGFloat) -> UIImage {
        let scale = width / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

