//
//  WeatherView.swift
//  Meterology
//
//  Created by Berk Dogan on 11/2/2022.
//

import SwiftUI

struct WeatherView: View {
	
	// Call Weather
	var weather: ResponseBody
	
	var body: some View {
		
		ZStack(alignment: .leading) {
			
			VStack {
			
				VStack(alignment: .leading, spacing: 5) {
					
					// Display city name
					Text(weather.name)
						.bold().font(.title)
					
					
					// Display today's date
					Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
						.fontWeight(.light)
					
					
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Spacer() // Full Screen
				
				
				VStack {
					HStack {
						
						VStack(spacing: 20) {
							Image(systemName: "sun.max")
								.font(.system(size: 40))
							
							Text(weather.weather[0].main)
						}
						.frame(width: 150, alignment: .leading)
						
						Spacer()
						
						// Display the temperature (feels like)
						Text(weather.main.feelsLike.roundDouble() + "°")
							.font(.system(size: 90))
							.fontWeight(.bold)
							.padding()
					}
					Spacer().frame(height:80) // give it a bit more gap
					
					AsyncImage(url: URL(string:
											"https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) {
						image in image
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 350)
					} placeholder: {
						ProgressView()
					}
					
					Spacer()
					
				}
				.frame(maxWidth: .infinity)
				
				
				
			}
			.padding()
			.frame(maxWidth: .infinity, alignment: .leading)
			
			VStack {
				Spacer()
				
				// This is where we implement the WeatherRow() functionality
				VStack(alignment: .leading, spacing: 20) {
					Text("Weather now")
						.bold().padding(.bottom)
					
					HStack {
						WeatherRow(logo: "thermometer", name: "Min Temp", value: (weather.main.tempMin.roundDouble() + "°"))
						Spacer()
						WeatherRow(logo: "thermometer", name: "Max Temp", value: (weather.main.tempMax.roundDouble() + "°"))
					}
					HStack {
						WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + "m/s"))
						Spacer()
						WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding()
				.padding(.bottom, 20)
				.foregroundColor(Color(hue: 0.666, saturation: 0.758, brightness: 0.408))
				.background(.white)
				.cornerRadius(20, corners: [.topLeft, .topRight])
			}
		}
		.edgesIgnoringSafeArea(.bottom)
		.background(Color(hue: 0.666, saturation: 0.758, brightness: 0.408))
		.preferredColorScheme(.dark)
	}
}

struct WeatherView_Previews: PreviewProvider {
	static var previews: some View {
		WeatherView(weather: previewWeather)
	}
}
