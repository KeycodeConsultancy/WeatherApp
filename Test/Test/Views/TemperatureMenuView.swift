import SwiftUI

public struct TemperatureMenuView: View {
    @Binding var isMenuOpen: Bool
    @Environment(WeatherViewModel.self) var viewModel

    public var body: some View {
        VStack(spacing: 10) {
            ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                Button(action: {
                    withAnimation { isMenuOpen = false }
                    viewModel.selectedUnit = unit
                    Task { await viewModel.fetchWeather() }
                }) {
                    Text(unit.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: WeatherConstants.buttonFrame.width,
                               height: WeatherConstants.buttonFrame.height)
                        .background(Color.blue)
                        .cornerRadius(WeatherConstants.cornerRadius)
                        .shadow(color: Color.gray.opacity(WeatherConstants.shadowOpacity),
                                radius: 3, x: 0, y: 3)
                }
            }
        }
        .padding(10)
        .background(Color.white.opacity(0.8))
        .cornerRadius(WeatherConstants.cornerRadius)
        .shadow(color: Color.gray.opacity(WeatherConstants.shadowOpacity), radius: 5, x: 0, y: 5)
    }
}
