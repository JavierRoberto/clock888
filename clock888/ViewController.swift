//
//  ViewController.swift
//  clock888
//
//  Created by Javier Roberto on 10/09/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    var startTime: Double = 0
    var time: Double = 0
    var timer: Timer?
    var isFirstTime: Bool = true
    
    lazy var clockView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    lazy var clockLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitle("title", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var bannerView: GADBannerView = {
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        return bannerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(clockView)
        clockView.addSubview(clockLabel)
        view.addSubview(button)
        view.addSubview(bannerView)
    }
    
    func setupConstraints() {
        clockLabel.fit(to: clockView, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        button.center(into: view)
        NSLayoutConstraint.activate([
            clockView.heightAnchor.constraint(equalToConstant: 100),
            clockView.widthAnchor.constraint(equalToConstant: 250),
            clockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 60),
            
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
    
    @objc func buttonAction() {
        isFirstTime ? initTime() : stopTime()
    }
    
    func initTime() {
        isFirstTime = false
        startTimer()
    }
    
    func stopTime() {
        isFirstTime = true
        timer?.invalidate()
        
    }
}

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(self.truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*1000).truncatingRemainder(dividingBy: 1000) )
    }
}
