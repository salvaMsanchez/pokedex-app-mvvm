//
//  DetailView.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 6/10/23.
//

import Foundation
import UIKit

final class DetailView: UIView {
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor(named: "homeCardBackground")?.cgColor
        if let uiImage = UIImage(systemName: "chevron.backward") {
            let image = uiImage.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.tintColor = UIColor(named: "pokemonName")
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pokemonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "pokemonName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 20
        uiView.backgroundColor = UIColor(named: "homeCardBackground")
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let weightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "customBlue")
        label.text = "Weight"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "customBlue")
        label.text = "Height"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let attackStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let attackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let attackTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "customBlue")
        label.text = "Attack"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let defenseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let defenseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let defenseTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "customBlue")
        label.text = "Defense"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineUiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "pokemonName")
        uiView.layer.cornerRadius = 5
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "pokemonName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "homeBackground")
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addViews()
        applyConstraints()
    }
    
    func addViews() {
        addSubview(backButton)
        addSubview(pokemonStackView)
        pokemonStackView.addArrangedSubview(pokemonImageView)
        pokemonStackView.addArrangedSubview(nameLabel)
        addSubview(typeLabel)
        addSubview(cardView)
        cardView.addSubview(cardStackView)
        cardStackView.addArrangedSubview(statsStackView)
        statsStackView.addArrangedSubview(weightStackView)
        weightStackView.addArrangedSubview(weightLabel)
        weightStackView.addArrangedSubview(weightTitleLabel)
        statsStackView.addArrangedSubview(heightStackView)
        heightStackView.addArrangedSubview(heightLabel)
        heightStackView.addArrangedSubview(heightTitleLabel)
        statsStackView.addArrangedSubview(attackStackView)
        attackStackView.addArrangedSubview(attackLabel)
        attackStackView.addArrangedSubview(attackTitleLabel)
        statsStackView.addArrangedSubview(defenseStackView)
        defenseStackView.addArrangedSubview(defenseLabel)
        defenseStackView.addArrangedSubview(defenseTitleLabel)
        cardStackView.addArrangedSubview(lineUiView)
        cardStackView.addArrangedSubview(descriptionTitleLabel)
        cardStackView.addArrangedSubview(descriptionLabel)
    }
    
    func applyConstraints() {
        let backButtonConstraints = [
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let pokemonStackViewConstraints = [
            pokemonStackView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -64),
            pokemonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            pokemonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ]
        
        let typeLabelConstraints = [
            typeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            typeLabel.topAnchor.constraint(equalTo: pokemonStackView.bottomAnchor, constant: 8)
        ]
        
        let pokemonImageViewConstraints = [
            pokemonImageView.heightAnchor.constraint(equalToConstant: 360)
        ]
        
        let cardViewConstraint = [
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -54),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let cardStackViewConstraints = [
            cardStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            cardStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            cardStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            cardStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16)
        ]
        
        let lineUiViewConstraints = [
            lineUiView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        NSLayoutConstraint.activate(backButtonConstraints)
        NSLayoutConstraint.activate(pokemonStackViewConstraints)
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        NSLayoutConstraint.activate(typeLabelConstraints)
        NSLayoutConstraint.activate(cardViewConstraint)
        NSLayoutConstraint.activate(cardStackViewConstraints)
        NSLayoutConstraint.activate(lineUiViewConstraints)
    }
    
    func configure(with model: DetailModel) {
        let weight: Double = Double(model.weight) / 10
        let height: Double = Double(model.height) / 10
        guard let url = URL(string: model.photo) else {
            return
        }
        pokemonImageView.setImage(for: url)
        nameLabel.text = model.name.capitalized
        typeLabel.text = model.type.capitalized + " Pokémon"
        weightLabel.text = "\(weight)kg"
        heightLabel.text = "\(height)m"
        attackLabel.text = "\(model.attack)"
        defenseLabel.text = "\(model.defense)"
        descriptionLabel.text = model.description
    }
    
    @objc
    func buttonTapped() {
        zoomOut()
        NotificationCenter.default.post(name: NSNotification.Name("BackButtonTapped"), object: nil)
    }
    
    @objc
    func buttonTouchDown() {
        zoomIn()
    }
    
}

// MARK: Animations
extension DetailView {
    func zoomIn() {
        UIView.animate(
            withDuration: 0.50,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.5
        ) { [weak self] in
            self?.backButton.transform = .identity.scaledBy(x: 0.94, y: 0.94)
        }
    }

    func zoomOut() {
        UIView.animate(
            withDuration: 0.50,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 2
        ) { [weak self] in
            self?.backButton.transform = .identity
        }
    }
}
