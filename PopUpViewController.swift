//
//  PopUpViewController.swift
//  WeatherApp
//
//  Created by Revanth Cherukuri on 4/13/22.
//

import UIKit
//import XCTest

class PopUpViewController: UIViewController {

    
    @IBOutlet weak var windSpeedValue: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    
    @IBOutlet weak var visibilityValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?zip=95014,us&units=imperial&appid=f7af919f29392723eebfe490931f076b")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {return}
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any], let weatherSys = json["sys"] as? [String : Any] else {return}
                    guard let weatherWind = json["wind"] as? [String : Any] else {return}
//                    guard let weatherVis = json["visibility"] as? [String : Any] else {return}
                    let humidity = Int(weatherMain["humidity"] as? Double ?? 0)
                    print(humidity)
                    let visibility = Int(weatherMain["visibility"]  as? Double ?? 0)
                    print(visibility)
                    let spd = Int(weatherWind["speed"] as? Double ?? 0)
                    print(spd)
                    DispatchQueue.main.async {
                        self.setWeather(humidity: humidity, visibility: visibility, spd: spd)
                    }

                } catch {
                    print("Could not retrieve weather...")
                }
            }
        }
        task.resume()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    func setWeather(humidity : Int, visibility : Int, spd : Int) {
        
        humidityValue.text = "\(humidity)%"
        visibilityValue.text = "\(visibility)"
        windSpeedValue.text = "\(spd) mph"
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.35, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.35, animations: {
            self.view.transform = CGAffineTransform(scaleX: 5.0,y: 5.0)
            self.view.alpha = 0.0;
        }, completion: {(finished : Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        });
    }
    
    @IBAction func closePopUp(_ sender: Any) {
//        self.view.removeFromSuperview()
        self.removeAnimate()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
