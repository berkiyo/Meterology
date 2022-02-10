//
//  WelcomeView.swift
//  Meterology
//
//  Created by Berk Dogan on 11/2/2022.
//

struct WelcomeView: View {
	
	@EnvironmentObject var locationManager: LocationManager
	
	var body: some View {
		VStack {
			VStack(spacing: 20) {
				Text("Welcome to Havalar!")
					.bold().font(.title)
				
				Text("Please share your current location to get the weather in your area")
					.padding()
			}
			.multilineTextAlignment(.center)
			.padding()
			
			LocationButton(.shareCurrentLocation) {
				locationManager.requestLocation()
			}
			.cornerRadius(30)
			.symbolVariant(.fill)
			.foregroundColor(.white)
			
		}
		.frame(
			  minWidth: 0,
			  maxWidth: .infinity,
			  minHeight: 0,
			  maxHeight: .infinity,
			  alignment: .center
		)
	}
}

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeView()
	}
}
