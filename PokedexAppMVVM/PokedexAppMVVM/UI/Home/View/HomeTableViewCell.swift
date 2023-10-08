//
//  HomeTableViewCell.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 5/10/23.
//

import Foundation
import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES -
    static let identifier = "HomeTableViewCell"
    
    private let cardView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 20
        uiView.backgroundColor = UIColor(named: "homeCardBackground")
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
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
    
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "customBlue")
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "homeBackground")
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setup() {
        addViews()
        applyConstraints()
    }
    
    private func addViews() {
        contentView.addSubview(cardView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(indexLabel)
        contentView.addSubview(pokemonImageView)
    }
    
    private func applyConstraints() {
        let cardViewConstraints = [
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16)
        ]
        
        let typeLabelConstraints = [
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            typeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16)
        ]
        
        let indexLabelConstraints = [
            indexLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 6),
            indexLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16)
        ]
        
        let pokemonImageViewConstraints = [
            pokemonImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 6),
            pokemonImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -6),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(cardViewConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(typeLabelConstraints)
        NSLayoutConstraint.activate(indexLabelConstraints)
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
    }
    
    public func configure(with model: HomeCellModel) {
        guard let url = URL(string: model.photo) else {
            return
        }
        pokemonImageView.setImage(for: url)
        nameLabel.text = model.name.capitalized
        typeLabel.text = model.type.capitalized + " Pokémon"
        if model.index < 10 {
            indexLabel.text = "#00\(model.index)"
        } else if model.index < 100 {
            indexLabel.text = "#0\(model.index)"
        } else {
            indexLabel.text = "#\(model.index)"
        }
        
    }
    
}
