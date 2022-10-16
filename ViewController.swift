//
//  ViewController.swift
//  WeatherApp
//
//  Created by Revanth Cherukuri on 2/27/22.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var tempDescriptionLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var feelsLikeValue: UILabel!
    @IBOutlet weak var tempHighValue: UILabel!
    @IBOutlet weak var tempLowValue: UILabel!
    @IBOutlet weak var locationValue: UILabel!
    @IBOutlet weak var timeValue: UILabel!
    @IBOutlet weak var weatherBackground: UIView!
    @IBOutlet weak var infoBackground: UIView!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let today = Date()
        let hour = (Calendar.current.component(.hour, from: today))
        let minute = (Calendar.current.component(.minute, from: today))
        var timeDisplay = ""
        if (hour > 12) {
            
            timeDisplay = String(format:"%d:%02d", hour-12, minute)
        }
        else {
            timeDisplay = String(format:"%d:%02d", hour, minute)
        }
        
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?zip=95014,us&units=imperial&appid=f7af919f29392723eebfe490931f076b")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {return}
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any], let weatherSys = json["sys"] as? [String : Any] else {return}
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let feelsLike = Int(weatherMain["feels_like"] as? Double ?? 0)
                    let highVal = Int(weatherMain["temp_max"] as? Double ?? 0)
                    let lowVal = Int(weatherMain["temp_min"] as? Double ?? 0)
                    
                    let sunriseUnix = weatherSys["sunrise"] ?? "nil"
                    let sunriseDate = Date(timeIntervalSince1970: sunriseUnix as! TimeInterval)
                    
                    let sunsetUnix = weatherSys["sunset"] ?? "nil"
                    let sunsetDate = Date(timeIntervalSince1970: sunsetUnix as! TimeInterval)
                    
                    let df = DateFormatter()
                    df.timeZone = TimeZone(abbreviation: "PST")
                    df.timeStyle = .short
                    df.locale = NSLocale.current
                    
                    let sunriseTime = df.string(from: sunriseDate)
                    let sunsetTime = df.string(from: sunsetDate)
                    
                    print(sunriseTime)
                    print(sunsetTime)
                    
                    let description = (weatherDetails.first?["description"] as? String)?.capitalized
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp, feelsLike: feelsLike, highVal: highVal, lowVal: lowVal, timeDisplay: timeDisplay, hour: hour, sunriseTime: sunriseTime, sunsetTime: sunsetTime)
                    }
                    
                    

                } catch {
                    print("Could not retrieve weather...")
                }
            }
        }
        task.resume()
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weatherPopUp") as! PopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    
    
    func setWeather(weather: String?, description: String?, temp: Int, feelsLike: Int, highVal: Int, lowVal: Int, timeDisplay: String, hour: Int, sunriseTime: String, sunsetTime: String) {
        tempDescriptionLabel.text = description ?? "..."
        tempValue.text = "\(temp)°"
        feelsLikeValue.text = "Feels like \(feelsLike)°"
        tempLowValue.text = "\(lowVal)°"
        tempHighValue.text = "\(highVal)°"
        
        weatherBackground.layer.cornerRadius = 35;
        weatherBackground.layer.shadowRadius = 5;
        weatherBackground.layer.shadowOpacity = 0.4;
        weatherBackground.layer.shadowColor = CGColor.init(red: 0.00, green: 0.0, blue: 0.0, alpha: 1.1);
        
        infoBackground.layer.cornerRadius = 30;

        tempLowValue.textColor = UIColor.systemTeal;
        tempHighValue.textColor = UIColor.systemOrange
        
        sunriseTimeLabel.text = sunriseTime
        sunsetTimeLabel.text = sunsetTime
        
        timeValue.text = timeDisplay
        
        
        
        switch hour {
        case 16,17,18:
            weatherBackground.backgroundColor = UIColor(red: 1.20, green: 0.78, blue: 0.35, alpha: 1.0)
        case 5,6,7,8:
            weatherBackground.backgroundColor = UIColor(red: 236/255, green: 125/255, blue: 182/255, alpha: 1.0);
        case 9,10,11,12,13,14,15:
            weatherBackground.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0);
        default:
            weatherBackground.backgroundColor = UIColor(red: 24/255, green: 0, blue: 104/255, alpha: 1.0);
//        default:
//            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
        }
    
    }
    
}

