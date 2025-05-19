import Foundation

public struct WeatherModel: Codable {
    let name: String
    let main: MainWeatherInfo
    let weather: [WeatherDescription]
    let wind: WindInfo
}
