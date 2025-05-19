import Foundation

public protocol WeatherService {
     func fetchWeather(for city: String, unit: TemperatureUnit) async throws -> WeatherModel
}

public final class WeatherServiceImpl: WeatherService {
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "OpenWeatherAPIKey") as? String ?? ""
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"

    public init() {}

    public func fetchWeather(for city: String, unit: TemperatureUnit) async throws -> WeatherModel {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseUrl)?q=\(encodedCity)&appid=\(apiKey)&units=\(unit.rawValue)") else {
            throw WeatherError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherError.requestFailed
        }

        do {
            return try JSONDecoder().decode(WeatherModel.self, from: data)
        } catch {
            throw WeatherError.decodingError
        }
    }
}
