//
//  BlurEffectView.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 26.09.2021.
//

import Foundation
import UIKit

class BlurEffect: UIVisualEffectView{
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: UIBlurEffect(style: .regular))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.opacity = 0.4
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
