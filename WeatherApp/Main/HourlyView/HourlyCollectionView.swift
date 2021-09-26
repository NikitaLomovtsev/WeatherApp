//
//  HourlyCollectionView.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 24.09.2021.
//

import Foundation
import UIKit

class HourlyCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var cells: [CurrentWeatherViewModel.Hourly]?
    
    //MARK: - init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset.left = 10
        contentInset.right = 10
        
        register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.reuseId)
    }
    
    func set(cells: [CurrentWeatherViewModel.Hourly]){
        self.cells = cells
        reloadData()
    }
    
    //MARK: - collectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cells = cells else { return 0 }
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.reuseId, for: indexPath) as! HourlyCollectionViewCell
        guard let cells = cells else { return cell}
        cell.set(data: cells[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (bounds.size.width - 50) / 4
        let height: CGFloat = 145
        return CGSize(width: width, height: height)
    }
    
    
    //
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
