//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 24.09.2021.
//

import Foundation
import UIKit

class HourlyCollectionViewCell: UICollectionViewCell{
    
    static let reuseId = "HourlyCollectionViewCell"
    
    //MARK: - variables
    private var blurEffectView = BlurEffect()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    private var conditionView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tempLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        contentView.addSubview(blurEffectView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(conditionView)
        contentView.addSubview(tempLabel)
        
        makeConstraints()
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        
        // blurEffectView constraints
        blurEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // dateLabel constraints
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // conditionView constraints
        conditionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        conditionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        conditionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        conditionView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        // tempLabel constraints
        tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    //MARK: - configure
    func set (data: CurrentWeatherViewModel.Hourly){
        dateLabel.text = data.dt
        conditionView.image = UIImage(named: data.icon)
        tempLabel.text = data.temp
    }
    
    //
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
