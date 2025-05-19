import SwiftUI

public struct WeatherDetailView: View {
    public let weather: WeatherModel
    public let unit: TemperatureUnit

    public init(weather: WeatherModel, unit: TemperatureUnit) {
        self.weather = weather
        self.unit = unit
    }

    public var body: some View {
        VStack(spacing: 24) {
            Text(weather.name)
                .font(.largeTitle.bold())
                .foregroundColor(.primary)
                .accessibilityLabel("City: \(weather.name)")

            HStack(spacing: 16) {
                Image(systemName: symbolForCondition())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(colorForCondition())
                    .accessibilityHidden(true)

                Text(formatTemperature(weather.main.temp, unit: unit))
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.primary)
                    .transition(.opacity)
                    .id(weather.main.temp)
                    .accessibilityLabel("Temperature is \(formatTemperature(weather.main.temp, unit: unit))")
            }

            VStack(spacing: 8) {
                MetricRow(systemIcon: "cloud.fill", label: weather.weather.first?.description.capitalized ?? "Clear", color: .white)
                MetricRow(systemIcon: "drop.fill", label: "Humidity: \(Int(weather.main.humidity))%", color: .blue)
                MetricRow(systemIcon: "wind", label: "Wind: \(Int(weather.wind.speed)) m/s", color: .gray)
            }
            .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(radius: 10)
        )
        .padding(.horizontal)
    }

    private func formatTemperature(_ temp: Double, unit: TemperatureUnit) -> String {
        switch unit {
        case .celsius: return String(format: "%.1f°C", temp + WeatherConstants.absoluteZeroInCelsius)
        case .fahrenheit:
            let celsius = temp + WeatherConstants.absoluteZeroInCelsius
            return String(format: "%.1f°F", celsius * 9 / 5 + 32)
        case .kelvin: return String(format: "%.1fK", temp)
        }
    }

    private func symbolForCondition() -> String {
        let description = weather.weather.first?.description.lowercased() ?? ""
        if description.contains("rain") {
            return "cloud.rain.fill"
        } else if description.contains("cloud") {
            return "cloud.fill"
        } else if description.contains("sun") || description.contains("clear") {
            return "sun.max.fill"
        } else {
            return "cloud.sun.fill"
        }
    }

    private func colorForCondition() -> Color {
        let description = weather.weather.first?.description.lowercased() ?? ""
        if description.contains("rain") {
            return .blue
        } else if description.contains("cloud") {
            return .white
        } else {
            return .yellow
        }
    }

    @ViewBuilder
    private func MetricRow(systemIcon: String, label: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemIcon)
                .foregroundColor(color)
                .accessibilityHidden(true)
            Text(label)
                .foregroundColor(.primary)
                .accessibilityLabel(label)
        }
    }
}
