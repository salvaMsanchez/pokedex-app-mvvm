//
//  DetailViewController.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 6/10/23.
//

import Foundation
import UIKit

// MARK: - PROTOCOL -
protocol DetailViewProtocol: AnyObject {
    func configureDetailData()
}

// MARK: - CLASS -
final class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModelProtocol?
    
    let detailView = DetailView()
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.onViewsLoaded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissDetail), name: NSNotification.Name("BackButtonTapped"), object: nil)
    }
    
    @objc
    func dismissDetail() {
        dismiss(animated: true)
    }
    
    deinit {
        // Desuscripción de la notificación cuando el ViewController se destruya
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - EXTENSION -
extension DetailViewController: DetailViewProtocol {
    func configureDetailData() {
        detailView.configure(with: viewModel?.pokemonDetailData ?? .init(name: "", photo: "", height: 0, weight: 0, attack: 0, defense: 0, type: "", description: ""))
    }
}
