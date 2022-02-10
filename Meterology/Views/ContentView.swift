//
//  ContentView.swift
//  Meterology
//
//  Created by Berk Dogan on 11/2/2022.
//

import SwiftUI

struct ContentView: View {
	@StateObject var locationManager = LocationManager()
	var weatherManager = WeatherManager()
	@State var weather: ResponseBody?
	
	
	var body: some View {
		VStack {
			if let location = locationManager.location {
				if let weather = weather {
					WeatherView(weather: weather)
				} else {
					LoadingView()
						.task {
							// the asynchronous weather fetcher
							do {
								try await
								weather = weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
							} catch {
								print("Error getting weather: \(error)")
							}
						}
				}
				
				
			} else {
				if locationManager.isLoading {
					LoadingView()
				} else {
					WelcomeView().environmentObject(locationManager)
				}
			}
			
		}
		// make it a full frame :)
		.frame(
			  minWidth: 0,
			  maxWidth: .infinity,
			  minHeight: 0,
			  maxHeight: .infinity,
			  alignment: .center
		)
		.background(Color(hue: 0.666, saturation: 0.758, brightness: 0.408))
		.preferredColorScheme(.dark)
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
