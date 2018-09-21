//
//  ViewController.swift
//  clock888
//
//  Created by Javier Roberto on 10/09/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit
import GoogleMobileAds
import TransitionTreasury
import TransitionAnimation

class ViewController: UIViewController, ModalTransitionDelegate {

    var startTime: Double = 0
    var time: Double = 0
    var timer: Timer?
    var isFirstTime: Bool = true
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topView, bottomView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 0.1)
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var clockLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont(name: "Hero", size: 70)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1)
        label.text = "0:00"
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "Hero", size: 40)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        button.setBackgroundImage(UIImage(named: "backgroundButton"), for: .normal)
        return button
    }()
    
    lazy var helpLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont(name: "Hero", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Time is going and you need to stop it at 8:88"
        return label
    }()
    
    lazy var bannerView: GADBannerView = {
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        return bannerView
    }()
    
    var tr_presentTransition: TRViewControllerTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    func setupView() {
        
        view.addSubview(stack)
        stack.addSubview(clockLabel)
        stack.addSubview(button)
        stack.addSubview(helpLabel)
        view.addSubview(bannerView)
    }
    
    
    
    func setupConstraints() {
        stack.fit(to: view)
        button.center(into: stack)
        NSLayoutConstraint.activate([
            clockLabel.heightAnchor.constraint(equalToConstant: 100),
            clockLabel.widthAnchor.constraint(equalToConstant: 250),
            clockLabel.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            clockLabel.topAnchor.constraint(equalTo: stack.topAnchor, constant: 100),

            button.heightAnchor.constraint(equalToConstant: 235),
            button.widthAnchor.constraint(equalToConstant: 235),

            helpLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            helpLabel.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            helpLabel.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 20),
            helpLabel.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -20),
            
            bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    func startTimer(){
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(advanceTimer),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func advanceTimer() {
        time = Date().timeIntervalSinceReferenceDate - startTime
        clockLabel.text = "\(time.minuteSecondMS)"
    }
    
    func present() {
        let happyVC = HappyVC()
        happyVC.modalDelegate = self // Don't forget to set modalDelegate
        tr_presentViewController(happyVC, method: TRPresentTransitionMethod.fade, completion: {
            print("Present finished.")
        })
    }
    
    @objc func buttonAction() {
//        isFirstTime ? initTime() : stopTime()
        present()
 
    }
    
    func initTime() {
        isFirstTime = false
        startTimer()
        button.setTitle("STOP", for: .normal)
    }
    
    func stopTime() {
        isFirstTime = true
        timer?.invalidate()
        button.setTitle("START", for: .normal)
        
    }
}

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%02d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(self.truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*100).truncatingRemainder(dividingBy: 100) )
    }
}

