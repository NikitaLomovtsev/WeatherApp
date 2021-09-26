//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 23.09.2021.
//

import UIKit
import CoreLocation

protocol WeatherDisplayLogic: AnyObject {
    func displayData(viewModel: WeatherEnum.Model.ViewModel.ViewModelData)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {
    
    var interactor: WeatherBusinessLogic?
    let weatherView = WeatherView()
    
    // MARK: - Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = WeatherInteractor()
        let presenter             = WeatherPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    
        view.addSubview(weatherView)
        weatherView.frame = self.view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        interactor?.makeRequest(request: .getWeather)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        weatherView.contentSize = CGSize(width:self.view.bounds.width, height: 845)
    }
    
    //MARK: - displayData
    func displayData(viewModel: WeatherEnum.Model.ViewModel.ViewModelData) {
        
        switch viewModel {

        case .displayWeather(let currentWeatherViewModel):
            weatherView.configure(viewModel: currentWeatherViewModel)
        }
    }
    
}
