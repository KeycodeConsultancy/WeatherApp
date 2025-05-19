import Foundation
import SwiftUI
import Observation

@MainActor
@Observable
public final class WeatherViewModel {
    public var selectedUnit: TemperatureUnit = .celsius
    public var city = ""
    public var weather: WeatherModel?
    public var isLoading = false
    public var errorMessage: String?

    private let service: WeatherService

    public init(service: WeatherService) {
        self.service = service
    }

    public func fetchWeather() async {
        guard !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let data = try await service.fetchWeather(for: city, unit: selectedUnit)
            self.weather = data
        } catch {
            self.errorMessage = error.localizedDescription
            clearErrorAfterDelay()
        }
    }

    public func dismissError() {
        errorMessage = nil
    }

    private func clearErrorAfterDelay() {
        Task {
            try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            if !Task.isCancelled {
                errorMessage = nil
            }
        }
    }
}
