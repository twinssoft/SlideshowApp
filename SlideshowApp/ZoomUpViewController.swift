//
//  ZoomUpViewController.swift
//  SlideshowApp
//
//  Created by Atsushi Suzuki on 2017/01/09.
//  Copyright © 2017年 atsushi.suzuki. All rights reserved.
//

import UIKit

class ZoomUpViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var imageIndex: Int = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var img: UIImage!
        
        switch imageIndex {
        case 0:
            img = UIImage(named: "cat.jpeg")
        case 1:
            img = UIImage(named: "dog.jpeg")
        default:
            img = UIImage(named: "bird.jpg")
            
        }
        imageView.image = img

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
