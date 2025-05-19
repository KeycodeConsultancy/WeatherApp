
import Foundation
import SwiftUI

#if DEBUG
class MockWeatherService: WeatherService {
    var shouldFail = false

    func fetchWeather(for city: String, unit: TemperatureUnit) async throws -> WeatherModel {
        if shouldFail {
            throw WeatherError.requestFailed
        }
        return WeatherModel(
            name: city,
            main: MainWeatherInfo(temp: 300.15, humidity: 50),
            weather: [WeatherDescription(description: "Clear sky", icon: "01d")],
            wind: WindInfo(speed: 5.0)
        )
    }
}
#endif
