import Foundation

public enum WeatherError: Error, Equatable {
    case invalidUrl
    case decodingError
    case requestFailed
}
