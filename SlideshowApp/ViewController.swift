//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Atsushi Suzuki on 2017/01/09.
//  Copyright © 2017年 atsushi.suzuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let CAT: Int = 0
    let DOG: Int = 1
    let BIRD: Int = 2
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    var timer: Timer!
    var imageIndex: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.isUserInteractionEnabled = true
        imageView.tag = 1
        viewImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if timer != nil {
            timer.invalidate()
        }
    }

    // 画像を表示する
    func viewImage() {
        var img: UIImage!

        switch imageIndex {
        case CAT:
            img = UIImage(named: "cat.jpeg")
        case DOG:
            img = UIImage(named: "dog.jpeg")
        case BIRD:
            img = UIImage(named: "bird.jpg")
        default:
            img = UIImage(named: "bird.jpg")
        }
        imageView.image = img
    }
    
    // タイマーによってコールされるメソッド
    func update(tm: Timer) {
        imageIndex += 1
        if imageIndex == 3 {
            imageIndex = 0
        }
        viewImage()
    }
    
    // 戻るボタン
    @IBAction func btnPrev(_ sender: Any) {
        imageIndex -= 1
        if imageIndex < 0 {
            imageIndex = 2
        }
        viewImage()
    }
    
    // 進むボタン
    @IBAction func btnNext(_ sender: Any) {
        imageIndex += 1
        if imageIndex == 3 {
            imageIndex = 0
        }
        viewImage()
    }
    
    // 再生・停止ボタン
    @IBAction func btnPlay(_ sender: Any) {
        if timer != nil && timer.isValid == true {
            resetButton()
            timer.invalidate()
        } else {
            stopButton()
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.update), userInfo: nil,  repeats: true)
            timer.fire()
        }
    }
    
    // イメージをタッチした時のメソッド
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case 1:
                resetButton()
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "zoom") as! ZoomUpViewController
                nextView.imageIndex = self.imageIndex
                self.present(nextView, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    // 遷移する前に呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let zoomupViewController: ZoomUpViewController = segue.destination as! ZoomUpViewController
        
        resetButton()
        zoomupViewController.imageIndex = self.imageIndex
    }

    // 再生中のボタンの状態にする
    func stopButton() {
        btnPlay.setTitle("停止", for: UIControlState.normal)
//        btnPrev.setTitle("戻る", for: UIControlState.disabled)
//        btnNext.setTitle("進む", for: UIControlState.disabled)
        btnPrev.isEnabled = false
        btnNext.isEnabled = false
    }
    
    // ボタンを初期状態に戻す
    func resetButton() {
        btnPlay.setTitle("再生", for: UIControlState.normal)
//        btnPrev.setTitle("戻る", for: UIControlState.normal)
//        btnNext.setTitle("進む", for: UIControlState.normal)
        btnPrev.isEnabled = true
        btnNext.isEnabled = true
    }
    
    // 遷移先から戻った時に呼ばれるメソッド
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
}

