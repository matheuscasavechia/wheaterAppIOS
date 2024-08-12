//
//  ContentView.swift
//  Shared
//
//  Created by Matheus Casavechia on 13/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()

    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?

    var body: some View {
        VStack{
            // teste de commit

            if let location = locationManager.location {
                if let weather = weather{
                    WeatherView(weather: weather)
                }else{
                    LoadingView().task{
                        do{
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        } catch{
                            print("Error getting weather: \(error)")
                        }
                    }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                }else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.636, saturation: 0.693, brightness: 0.593))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
