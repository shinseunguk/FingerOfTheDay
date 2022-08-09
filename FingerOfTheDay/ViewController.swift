//
//  ViewController.swift
//  FingerOfTheDay
//
//  Created by ukBook on 2022/08/07...
//

// 롱프레스 및 햅틱진동 구현하기
// https://h1guitar.tistory.com/228

// tab and touch example
// https://moonibot.tistory.com/50

// TGP Control
// https://github.com/SwiftArchitect/TGPControls

import UIKit
import AudioToolbox
import TGPControls

class ViewController: UIViewController {
    
    let helper : Helper = Helper()
    
    // 터치 할수있는 수
    var fingerCount : Int = 2;
    
    @IBOutlet weak var selectServerButton: UIButton!
    @IBOutlet var uiView: UIView!
    
    @IBOutlet weak var oneTo10Labels: TGPCamelLabels!
    @IBOutlet weak var oneTo10Slider: TGPDiscreteSlider!
    
    private func localizedStrings(_ key: String) -> [String] {
        return NSLocalizedString(key, comment: "")
            .split(separator: " ")
            .map({ (substring) -> String in
                return "\(substring)"
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        oneTo10Labels.names = localizedStrings("oneTo10Labels.numbers")
        oneTo10Slider.ticksListener = oneTo10Labels
        
//        print("\(#function)")
//
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
//             self.selectServerButton.addGestureRecognizer(longPress)
        self.uiView.addGestureRecognizer(longPress)
//            // 롱프레스 시간설정
        longPress.minimumPressDuration = 3
        
        oneTo10Slider.addTarget(self, action: #selector(ViewController.valueChanged(_:event:)), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        self.uiView.backgroundColor = UIColor(patternImage: UIImage(named: "space.jpeg")!)
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
    
    // 터치가 시작될 때 호출
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 현재 발생한 터치 이벤트를 가지고 옴
        let touchCount = touches.count
        let touch = touches.first! as UITouch
        let tapCount = touch.tapCount
        
        print("\(touchCount) touches")
        print("\(tapCount) taps")
    }

    // 터치된 손가락이 움직였을 때 호출
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first! as UITouch
//
//        print("Touches Moved ", String(touches.count))
//    }

    // 화면에서 손가락을 떼엇을 때 호출
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first! as UITouch
//
//        print("Touches Ended tapCount", String(touch.tapCount))
//        print("Touches Ended ", String(touches.count))
//    }
    
    @objc func valueChanged(_ sender: TGPDiscreteSlider, event:UIEvent) {
        print(Int(sender.value)+2)
        
        fingerCount = Int(sender.value)+2
    }
    
}

