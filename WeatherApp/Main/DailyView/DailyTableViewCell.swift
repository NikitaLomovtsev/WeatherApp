//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 25.09.2021.
//

import Foundation
import UIKit

class DailyTableViewCell: UITableViewCell{
    
    static let reuseId = "DailyTableViewCell"
    
    //MARK: - variables
    private var blurEffectView = BlurEffect()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = "сегодня"
        return label
    }()
    
    private var conditionView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "09d")
        return view
    }()
    
    private var maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "+15º"
        return label
    }()
    
    private var minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "+10º"
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(blurEffectView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(conditionView)
        contentView.addSubview(minLabel)
        contentView.addSubview(maxLabel)
        
        makeConstraints()
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        
        //blurEffectView constraints
        blurEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // dateLabel constraints
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        // conditionView constraints
        conditionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        conditionView.trailingAnchor.constraint(equalTo: maxLabel.leadingAnchor, constant: -18).isActive = true
        conditionView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        conditionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //minLabel constraints
        minLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
        minLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        //maxLabel constraints
        maxLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        maxLabel.trailingAnchor.constraint(equalTo: minLabel.leadingAnchor, constant: -8).isActive = true
        maxLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    //MARK: - configure
    func set (data: CurrentWeatherViewModel.Daily){
        dateLabel.text = String(data.dt)
        conditionView.image = UIImage(named: data.icon)
        minLabel.text = data.minTemp
        maxLabel.text = data.maxTemp
    }
        
    //
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
