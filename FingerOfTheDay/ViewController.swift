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

// 그리는 앱 만들기 => 참고 할 것!
// https://bite-sized-learning.tistory.com/507

// 멀티터치 앱 예제
// https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view/implementing_a_multi-touch_app

import UIKit
import AudioToolbox
import TGPControls

class ViewController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    let helper : Helper = Helper()
    
    // 터치 할수있는 수
    var fingerCount : Int = 2;
    
    @IBOutlet weak var selectServerButton: UIButton!
    @IBOutlet var uiView: UIView!
    
    @IBOutlet weak var oneTo10Labels: TGPCamelLabels!
    @IBOutlet weak var oneTo10Slider: TGPDiscreteSlider!
    
    var imageView1 : UIImageView!
    
    private func localizedStrings(_ key: String) -> [String] {
        return NSLocalizedString(key, comment: "")
            .split(separator: " ")
            .map({ (substring) -> String in
                return "\(substring)"
            })
    }
    
    // status bar font color
    override var preferredStatusBarStyle: UIStatusBarStyle {
            
        // 글자색을 흰색으로
        return .lightContent
        
        // 글자색을 검은색으로
        //return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        oneTo10Labels.names = localizedStrings("oneTo10Labels.numbers")
        oneTo10Slider.ticksListener = oneTo10Labels
        
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
        centerLabel.fadeOut()
        oneTo10Labels.fadeOut()
        oneTo10Slider.fadeOut()
        // 현재 발생한 터치 이벤트를 가지고 옴
        let touchCount = touches.count
        let touch = touches.first! as UITouch
        let point = touch.location(in: touch.view)
        
        print("touchesBegan \(touch) touche")
        print("touchesBegan \(touchCount) touches")
//        print("touchesBegan \(tapCount) taps")
//        print("touchesBegan \(point.x) taps")
//        print("touchesBegan \(point.y) taps")
        
        imageView1  = UIImageView(frame:CGRect(x: point.x-50, y: point.y-50, width: 100, height: 100));
        imageView1.image = UIImage(named:"red.png")
        imageView1.layer.cornerRadius = imageView1.frame.height/2
        imageView1.layer.masksToBounds = true
        self.uiView.addSubview(imageView1)
        
//        perform(#selector(delayedFunc), with: nil, afterDelay: 0.5)
//        perform(#selector(delayedFunc), with: nil, afterDelay: 1)
//        perform(#selector(delayedFunc), with: nil, afterDelay: 1.5)
//        perform(#selector(delayedFunc), with: nil, afterDelay: 2)
        
//        print("fingerCount ", fingerCount)
    }

    // 터치된 손가락이 움직였을 때 호출
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchCount = touches.count
        let touch = touches.first! as UITouch
        let tapCount = touch.tapCount
        let point = touch.location(in: touch.view)
        
//        print("touchesMoved \(touchCount) touches")
//        print("touchesMoved \(tapCount) taps")
        
        self.imageView1.removeFromSuperview()
        
        imageView1  = UIImageView(frame:CGRect(x: point.x-50, y: point.y-50, width: 100, height: 100));
        imageView1.image = UIImage(named:"red.png")
        imageView1.layer.cornerRadius = imageView1.frame.height/2
        imageView1.layer.masksToBounds = true
        
        self.uiView.addSubview(imageView1)
        
//        perform(#selector(delayedFunc), with: nil, afterDelay: 0.5)
//        perform(#selector(delayedFunc), with: nil, afterDelay: 1)
//        perform(#selector(delayedFunc), with: nil, afterDelay: 1.5)
//        perform(#selector(delayedFunc), with: nil, afterDelay: 2)
        
//        print("Touches Moved ", String(touches.count))
    }

    // 화면에서 손가락을 떼엇을 때 호출
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        centerLabel.fadeIn()
        oneTo10Labels.fadeIn()
        oneTo10Slider.fadeIn()
        
        // 현재 발생한 터치 이벤트를 가지고 옴
        let touchCount = touches.count
        let touch = touches.first! as UITouch
        let point = touch.location(in: touch.view)
        
        print("touchesEnded \(touch) touche")
        print("touchesEnded \(touchCount) touches")
        
        self.imageView1.removeFromSuperview()
        print(#function)
    }
    
    // 화면에서 손가락을 떼엇을 때 호출
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        centerLabel.fadeIn()
        oneTo10Labels.fadeIn()
        oneTo10Slider.fadeIn()
        
        self.imageView1.removeFromSuperview()
        print(#function)
    }
    
    @objc func valueChanged(_ sender: TGPDiscreteSlider, event:UIEvent) {
        print(Int(sender.value)+2)
        
        fingerCount = Int(sender.value)+2
    }
    
    @IBAction func delayedFunc() {
           self.imageView1.transform = self.imageView1.transform.rotated(by: .pi/2)
   }
    
}
