//
//  SplashViewController.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 5/10/23.
//

import Foundation
import UIKit

// MARK: - PROTOCOL -
protocol SplashViewProtocol: AnyObject {
    func showLoading(_ show: Bool)
    func navigateToHome(pokemons: [HomeCellModel])
}

// MARK: - CLASS -
final class SplashViewController: UIViewController {
    // ViewModel
    var viewModel: SplashViewModelProtocol?
    // CustomView
    let splashView = SplashView()
    
    override func loadView() {
        super.loadView()
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        splashView.splashActivityIndicator.stopAnimating()
    }
    
}

// MARK: - EXTENSION -
extension SplashViewController: SplashViewProtocol {
    func navigateToHome(pokemons: [HomeCellModel]) {
        let nextVC = HomeViewController()
//        nextVC.pokemons = pokemons
        nextVC.viewModel = HomeViewModel(viewDelegate: nextVC, pokemons: pokemons)
        
        navigationController?.setViewControllers([nextVC], animated: true)
    }
    
    func showLoading(_ show: Bool) {
        switch show {
            case true where !splashView.splashActivityIndicator.isAnimating:
                splashView.splashActivityIndicator.startAnimating()
            case false where splashView.splashActivityIndicator.isAnimating:
                splashView.splashActivityIndicator.stopAnimating()
            default:
                break
        }
    }
}
