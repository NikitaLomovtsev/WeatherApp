//
//  BottomView.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 26.09.2021.
//

import Foundation
import UIKit

class BottomView: UIView{
    
    //MARK: - variables
    
    static var height: CGFloat?
    
    private var blurEffectView = BlurEffect()
    
    private var staticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textAlignment = .left
        label.text = "Что надеть:"
        return label
    }()
    
    private var wearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Свитер и куртка, джинсы, Свитер и куртка, джинсы,Свитер и куртка"
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(blurEffectView)
        self.addSubview(staticLabel)
        self.addSubview(wearLabel)
        
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
        
        // staticLabel constraints
        staticLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        staticLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        staticLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        // dressLabel constraints
        wearLabel.topAnchor.constraint(equalTo: staticLabel.bottomAnchor, constant: 8).isActive = true
        wearLabel.leadingAnchor.constraint(equalTo: staticLabel.leadingAnchor).isActive = true
        wearLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true
        wearLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
    }
    
    //MARK: - configure
    func set(temp: String){
        wearLabel.text = configureWearLabel(temp: temp)
    }
    
    let autumnWarmTopWear = ["пальто", "куртка", "бомбер"]
    let summerTopWear = ["футболка", "рубашка", "поло", "майка"]
    let autumnTopWear = ["джинсовка", "ветровка"]
    let topWear = ["худи", "свитер", "толстовка", "свитшот"]
    let bottomWear = ["брюки", "джинсы", "штаны"]
    let shoes = ["кроссовки", "ботинки"]
    
    func configureWearLabel(temp: String) -> String{
        var currentTemp = temp.dropLast(1)
        if currentTemp.hasPrefix("+"){
            currentTemp = currentTemp.dropFirst(1)
        }
        switch Int(currentTemp)! {
        case -50...(-11):
            return "термобелье, \(topWear.shuffled()[0]), пуховик, \(bottomWear.shuffled()[0]), теплая обувь, шарф, шапка и перчатки.".capitalizingFirstLetter()
        case -10...(-4):
            return "\(topWear.shuffled()[0]), пальто или пуховик, \(bottomWear.shuffled()[0]), теплая обувь, шарф, шапка и перчатки.".capitalizingFirstLetter()
        case -5...(-1):
            return "\(topWear.shuffled()[0]), \(autumnWarmTopWear.shuffled()[0]), \(bottomWear.shuffled()[0]), ботинки, шарф, шапка и перчатки.".capitalizingFirstLetter()
        case 0...4:
            return "\(topWear.shuffled()[0]), \(autumnWarmTopWear.shuffled()[0]), \(bottomWear.shuffled()[0]), ботинки, шарф и перчатки.".capitalizingFirstLetter()
        case 5...9:
            return "\(topWear.shuffled()[0]), \(autumnWarmTopWear.shuffled()[0]), \(bottomWear.shuffled()[0]), ботинки.".capitalizingFirstLetter()
        case 10...14:
            return "\(topWear.shuffled()[0]), \(autumnTopWear.shuffled()[0]), \(bottomWear.shuffled()[0]), \(shoes.shuffled()[0]).".capitalizingFirstLetter()
        case 15...19:
            return "\(summerTopWear.shuffled()[0]), \(autumnTopWear.shuffled()[0]) или \(topWear.shuffled()[0]), \(bottomWear.shuffled()[0]), \(shoes.shuffled()[0]).".capitalizingFirstLetter()
        case 20...25:
            return "\(summerTopWear.shuffled()[0]), \(bottomWear.shuffled()[0]), \(shoes.shuffled()[0]).".capitalizingFirstLetter()
        case 26...50:
            return "\(summerTopWear.shuffled()[0]), шорты или \(bottomWear.shuffled()[0]), легкая обувь.".capitalizingFirstLetter()
        default:
            return ""
        }
    }
    
    //
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
