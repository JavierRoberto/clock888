//
//  SadVC.swift
//  clock888
//
//  Created by Javier Roberto on 20/09/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import GoogleMobileAds
import UIKit

class SadVC: UIViewController {
    private var interstitial: GADInterstitialAd?

    var time: Double = 0

    let heightDismissButton: CGFloat = 60

    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 0.1)
        return view
    }()

    lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sad")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var noLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "no_key".localized
        label.sizeToFit()
        label.font = UIFont(name: "Hero", size: 46)
        label.textAlignment = .center
        return label
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "result_key".localized + time.secondMS
        label.sizeToFit()
        label.textColor = UIColor(red: 244 / 255, green: 104 / 255, blue: 84 / 255, alpha: 1)
        label.font = UIFont(name: "Hero", size: 20)
        label.textAlignment = .center
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "you_were_close".localized + time.timeTo888 + "sec".localized
        label.font = UIFont(name: "Hero", size: 20)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()

    lazy var dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("try_again".localized, for: .normal)

        button.titleLabel?.font = UIFont(name: "Hero", size: 26)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.38, alpha: 1)
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 32
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return button
    }()

    fileprivate func setUpAd() {
        Task {
            do {
                // de pruebas -> "ca-app-pub-3940256099942544/4411468910"
                interstitial = try await GADInterstitialAd.load(
                    withAdUnitID: "ca-app-pub-7177564470506351/4058926558", request: GADRequest()
                )
            } catch {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
            }
        }
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupView()
        setupConstraints()
        setUpAd()
    }

    func setupView() {
        view.addSubview(topView)
        view.addSubview(dismissButton)
        topView.addSubview(icon)
        topView.addSubview(noLabel)
        topView.addSubview(timeLabel)
        topView.addSubview(descriptionLabel)
    }

    func setupConstraints() {
        topView.fit(toTop: view)
        noLabel.center(into: topView)
        timeLabel.fit(horizontal: view, below: noLabel, insets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        descriptionLabel.fit(horizontal: view, below: timeLabel, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        noLabel.fit(horizontal: view, below: icon, insets: UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0))

        NSLayoutConstraint.activate([
            topView.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: heightDismissButton / 2),

            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 128),
            icon.widthAnchor.constraint(equalToConstant: 128),

            dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            dismissButton.heightAnchor.constraint(equalToConstant: heightDismissButton),
        ])
    }

    @objc func dismissView() {
        dismiss(animated: true) { [weak self] in
            self?.interstitial?.present(fromRootViewController: nil)
        }
    }
}

extension SadVC: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError _: Error) {
        print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
}
