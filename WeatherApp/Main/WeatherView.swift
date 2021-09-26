//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 23.09.2021.
//

import Foundation
import UIKit
import AVFoundation

class WeatherView: UIScrollView{
    
    //MARK: - variables
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer?
    var playerLooper: AVPlayerLooper?
    var playerItem: AVPlayerItem?
    
    private var mainView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        label.text = "Загрузка..."
       return label
    }()
    
    private var cityLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .right
        label.text = "-"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .left
        label.text = "-"
        return label
    }()
    
    private var descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .right
        return label
    }()
    
    private var maxMinLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.systemFont(ofSize: 18)
         label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         label.textAlignment = .right
        return label
    }()
    
    private var videoView: UIView = {
        let videoView = UIView()
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.alpha = 0
        return videoView
    }()
    
    private var hourlyCollectionView = HourlyCollectionView()
    private var dailyTableView = DailyTableView()
    private var bottomView = BottomView()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSelfScrollView()
        addSubview(loadingLabel)
        addSubview(mainView)
        mainView.addSubview(videoView)
        mainView.addSubview(cityLabel)
        mainView.addSubview(tempLabel)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(maxMinLabel)
        mainView.addSubview(hourlyCollectionView)
        mainView.addSubview(dailyTableView)
        mainView.addSubview(bottomView)
        makeConstraints()
    }
    
    func configureSelfScrollView(){
        self.bounces = false
        self.contentInsetAdjustmentBehavior = .never
        self.showsVerticalScrollIndicator = false
        backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3764705882, blue: 0.5333333333, alpha: 1)
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        
        // loadingLabel constraints
        loadingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 160).isActive = true
        loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // mainView constraints
        mainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        mainView.contentHuggingPriority(for: .vertical)
        
        // cityLabel constraints
        cityLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 160).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -18).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10).isActive = true
        
        // tempLabel constraints
        tempLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        tempLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor).isActive = true
        tempLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        // descriptionLabel constraints
        descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -18).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        // maxMinLabel constraints
        maxMinLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        maxMinLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -18).isActive = true
        maxMinLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        // videoView constraints
        videoView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        videoView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: dailyTableView.bottomAnchor, constant: 10).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        
        
    }
    
    //MARK: - configure
    func configure (viewModel: CurrentWeatherViewModel){
        DispatchQueue.main.async {
            self.loadingLabel.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.allowUserInteraction], animations:
                            { () -> Void in
                                self.mainView.alpha = 1
                            })
            self.configureBackgroundColor(icon: viewModel.icon)
            self.backgroundColor = self.mainView.backgroundColor
            self.configureWeatherConditionVideo(icon: viewModel.icon)
            self.cityLabel.text = viewModel.locality
            self.tempLabel.text = viewModel.temp
            self.descriptionLabel.text = viewModel.weatherDescription
            self.maxMinLabel.text = viewModel.maxMinTemp
            
            self.hourlyCollectionView.frame = CGRect(x: 0,
                                                     y: self.maxMinLabel.frame.maxY + 10,
                                                     width: self.frame.width,
                                                     height: 165)
            self.hourlyCollectionView.set(cells: viewModel.hourlyWeather)
            
            self.dailyTableView.frame = CGRect(x: 10,
                                               y: self.hourlyCollectionView.frame.maxY,
                                               width: self.frame.width - 20,
                                               height: DailyTableView.cellHeight * 7)
            self.dailyTableView.set(cells: viewModel.dailyWeather)
            
            self.bottomView.set(temp: viewModel.temp)
        }
    }
    
    private func configureWeatherConditionVideo(icon: String){
        
        guard let path = Bundle.main.path(forResource: icon, ofType:"mp4") else { return }
        player = AVQueuePlayer()
        playerLayer = AVPlayerLayer(player: self.player)
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        playerLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLooper = AVPlayerLooper(player: self.player as! AVQueuePlayer, templateItem: self.playerItem!)

        videoView.layer.addSublayer(self.playerLayer!)
        self.playerLayer?.frame = self.videoView.bounds
        self.player.play()
        UIView.animate(withDuration: 1, delay: 0.3, options: [.allowUserInteraction], animations:
                        { () -> Void in
                            self.videoView.alpha = 0.75
                        })
    }
    
    private func configureBackgroundColor(icon: String){
        switch icon {
        case "01d":
            mainView.backgroundColor = #colorLiteral(red: 0.1113159284, green: 0.5214003325, blue: 0.9103012681, alpha: 1)
        case "02d", "03d", "04d", "unknown":
            mainView.backgroundColor = #colorLiteral(red: 0.22819677, green: 0.5419401526, blue: 0.7971643806, alpha: 1)
        case "09d","09n", "10d","10n", "13d", "13n":
            mainView.backgroundColor = #colorLiteral(red: 0.1830025315, green: 0.3757502437, blue: 0.5348874927, alpha: 1)
        case "50d":
            mainView.backgroundColor = #colorLiteral(red: 0.2699401379, green: 0.5616410375, blue: 0.7918332219, alpha: 1)
        case "01n", "02n", "03n", "04n":
            mainView.backgroundColor = #colorLiteral(red: 0.03176918998, green: 0.1420978308, blue: 0.28448385, alpha: 1)
        case "11d", "11n":
            mainView.backgroundColor = #colorLiteral(red: 0.149156034, green: 0.3194305599, blue: 0.5500941873, alpha: 1)
        case "50n":
            mainView.backgroundColor = #colorLiteral(red: 0.3737272024, green: 0.5172019601, blue: 0.5837426186, alpha: 1)
        default:
            print("213")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
