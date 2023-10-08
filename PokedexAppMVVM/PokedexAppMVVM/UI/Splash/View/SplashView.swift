//
//  SplashView.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 5/10/23.
//

import Foundation
import UIKit

final class SplashView: UIView {
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundSplash")
        imageView.alpha = 0.8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let activityIndicatorUiView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 20
        uiView.backgroundColor = .black.withAlphaComponent(0.6)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    public let splashActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .green
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = bounds
    }
    
    private func setup() {
        addViews()
        applyConstraints()
    }

    private func addViews() {
        addSubview(backgroundImage)
        addSubview(splashActivityIndicator)
        addSubview(activityIndicatorUiView)
    }

    private func applyConstraints() {
        let activityIndicatorUiViewConstraints = [
            activityIndicatorUiView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorUiView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorUiView.widthAnchor.constraint(equalToConstant: 80),
            activityIndicatorUiView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let splashActivityIndicatorConstraints = [
            splashActivityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorUiView.centerXAnchor),
            splashActivityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorUiView.centerYAnchor)
        ]

        NSLayoutConstraint.activate(splashActivityIndicatorConstraints)
        NSLayoutConstraint.activate(activityIndicatorUiViewConstraints)
    }
    
}
