//
//  Extension + String.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 25.09.2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

}
