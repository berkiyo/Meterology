//
//  WeatherManager.swift
//  Meterology
//
//  Created by Berk Dogan on 11/2/2022.
//

import Foundation
import CoreLocation

class WeatherManager {
	// HTTP request to get the current weather depending on the coordinates we got from LocationManager
	func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
		// Replace YOUR_API_KEY in the link below with your own
		guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=cbdea503d8ed41040fe0527cd6296b67&units=metric") else { fatalError("Missing URL") }


		let urlRequest = URLRequest(url: url)
		
		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		
		guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
		
		let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
		
		return decodedData
	}
}

/**
 Imported from GitHub repo: https://github.com/stephdiep/WeatherApp/blob/main/WeatherApp/Managers/WeatherManager.swift
 */
struct ResponseBody: Decodable {
	var coord: CoordinatesResponse
	var weather: [WeatherResponse]
	var main: MainResponse
	var name: String
	var wind: WindResponse

	struct CoordinatesResponse: Decodable {
		var lon: Double
		var lat: Double
	}

	struct WeatherResponse: Decodable {
		var id: Double
		var main: String
		var description: String
		var icon: String
	}

	struct MainResponse: Decodable {
		var temp: Double
		var feels_like: Double
		var temp_min: Double
		var temp_max: Double
		var pressure: Double
		var humidity: Double
	}
	
	struct WindResponse: Decodable {
		var speed: Double
		var deg: Double
	}
}

extension ResponseBody.MainResponse {
	var feelsLike: Double { return feels_like }
	var tempMin: Double { return temp_min }
	var tempMax: Double { return temp_max }
}
