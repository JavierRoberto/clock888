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
import CoreData

protocol ViewControllerDelegate {
    func pass(level: Level)
}

class ViewController: UIViewController, ModalTransitionDelegate {

    var level: Level = .bronze
    
    var startTime: Double = 0
    var time: Double = 0
    var timer: Timer?
    var isFirstTime: Bool = true
    
    
    lazy var levelButton: UIBarButtonItem = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "podium"), for: .normal)
        button.addTarget(self, action: #selector(presentLevels), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var resultButton: UIBarButtonItem = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "podium"), for: .normal)
        button.addTarget(self, action: #selector(presentResult), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
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
        label.font = UIFont(name: "Anonymous Pro", size: 70)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.99, green: 0.55, blue: 0.4, alpha: 1)
        label.text = "0:00"
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("start_key".localized, for: .normal)
        
        button.titleLabel?.font = UIFont(name: "Hero", size: 40)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        
        button.setBackgroundImage(UIImage(named: "backgroundButton"), for: .normal)
        return button
    }()
    
    lazy var goToHappyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("go to Happy", for: .normal)
        button.isHidden = false
        button.titleLabel?.font = UIFont(name: "Hero", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(presentHappy), for: UIControl.Event.touchUpInside)
        button.backgroundColor = .red
//        button.setBackgroundImage(UIImage(named: "backgroundButton"), for: .normal)
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
        label.text = "main_description".localized
        return label
    }()
    
    lazy var bannerView: GADBannerView = {
        let banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        //        "ca-app-pub-7177564470506351/9126892708" --> token bueno
        //        "ca-app-pub-3940256099942544/2934735716" --> token de prueba
        banner.rootViewController = self
        return banner
    }()
    
//    lazy var bannerView: GADBannerView = {
//        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        bannerView.adUnitID = "ca-app-pub-7419924566886338/3812899263"
//        bannerView.delegate = self
//        //  REAL:ca-app-pub-7419924566886338/3812899263
//        //  TESTING "ca-app-pub-3940256099942544/2934735716"
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//        return bannerView
//    }()
    
    var tr_presentTransition: TRViewControllerTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        
        bannerView.delegate = self
        bannerView.load(GADRequest())
        
        
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
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
        view.addSubview(goToHappyButton)
        
        navigationItem.setLeftBarButton(levelButton, animated: true)
        navigationItem.setRightBarButton(resultButton, animated: true)
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
            bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            goToHappyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            goToHappyButton.heightAnchor.constraint(equalToConstant: 40),
            goToHappyButton.widthAnchor.constraint(equalToConstant: 200),
            goToHappyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    func startTimer(){
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                             target: self,
                             selector: #selector(advanceTimer),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func advanceTimer() {
        time = Date().timeIntervalSinceReferenceDate - startTime
        if time.secondMS == "10:00" {
            presentSad(time: time)
            timer?.invalidate()
            save(time: time.secondMS)
            
        }
        clockLabel.text = "\(time.secondMS)"
    }
    
    
    @objc func presentLevels() {
        let levelsVC = LevelsVC()
        levelsVC.delegate = self
        levelsVC.modalTransitionStyle = .crossDissolve
        levelsVC.modalPresentationStyle = .overCurrentContext
        present(levelsVC, animated: true, completion: nil)
//        navigationController?.pushViewController(levelsVC, animated: true)
        //        resultVC.modalDelegate = self // Don't forget to set modalDelegate
        //        tr_presentViewController(resultVC, method: TRPresentTransitionMethod.fade, completion: {
        //            print("Present finished.")
        //        })
    }
    
    
    @objc func presentResult() {
        let resultVC = ResultVC()
        navigationController?.pushViewController(resultVC, animated: true)
//        resultVC.modalDelegate = self // Don't forget to set modalDelegate
//        tr_presentViewController(resultVC, method: TRPresentTransitionMethod.fade, completion: {
//            print("Present finished.")
//        })
    }
    
    @objc func presentHappy() {
        let happyVC = HappyVC()
        
        happyVC.modalDelegate = self // Don't forget to set modalDelegate
        tr_presentViewController(happyVC, method: TRPresentTransitionMethod.fade, completion: {
            print("Present finished.")
        })
    }
    
    func presentSad(time: Double) {
        let sadVC = SadVC()
        sadVC.time = time
        sadVC.modalDelegate = self // Don't forget to set modalDelegate
        tr_presentViewController(sadVC, method: TRPresentTransitionMethod.fade, completion: {
            print("Present finished.")
        })
    }
    
    @objc func buttonAction() {
        isFirstTime ? initTime() : stopTime()
//        present()
        
 
    }
    
    
    func initTime() {
        isFirstTime = false
        startTimer()
        button.setTitle("stop_key".localized, for: .normal)
    }
    
    func stopTime() {
        isFirstTime = true
        button.setTitle("start_key".localized, for: .normal)
        
        if time.secondMS == "08:88" {
            presentHappy()
        } else {
            presentSad(time: time)
        }
        timer?.invalidate()
        save(time: time.secondMS)
        
    }
    
    func save(time: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Result", in: managedContext)!
        let result = NSManagedObject(entity: entity, insertInto: managedContext)
        result.setValue(time, forKeyPath: "timeResult")
        result.setValue(Date(), forKeyPath: "timeStamp")
        do {
            try managedContext.save()
//            result.append(time)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

extension ViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

extension ViewController: ViewControllerDelegate {
    func pass(level: Level) {
        self.level = level
    }
    
    
}
