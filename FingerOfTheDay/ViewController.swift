//
//  ViewController.swift
//  FingerOfTheDay
//
//  Created by ukBook on 2022/08/07...
//

// 롱프레스 및 햅틱진동 구현하기
// https://h1guitar.tistory.com/228

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    let helper : Helper = Helper()
    
    @IBOutlet weak var selectServerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\(#function)")
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
             self.selectServerButton.addGestureRecognizer(longPress)
            // 롱프레스 시간설정
            longPress.minimumPressDuration = 3
    }
    
    @objc func longPress(_ guesture: UILongPressGestureRecognizer) {
            if guesture.state == UIGestureRecognizer.State.began {
                print("LongPressGesture is Recognized")
                        AudioServicesPlaySystemSound(1520);
                helper.showAlertAction1(vc: self, preferredStyle: .alert, title: "알림", message: "터치 3초", completeTitle: "확인", nil)
                // 구현할 기능 넣기
            }
                return
      }


}

