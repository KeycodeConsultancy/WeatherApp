import SwiftUI
import Observation

public struct ContentView: View {
    @Bindable public var viewModel: WeatherViewModel
    @State private var isMenuOpen = false

    public init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                LinearGradient(
                    gradient: Gradient(colors: WeatherConstants.gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 12) {
                    
                    if let error = viewModel.errorMessage {
                        HStack {
                            Spacer()
                            Text(error)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                                .overlay(
                                    Button(action: { viewModel.dismissError() }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                    .padding(6),
                                    alignment: .topTrailing
                                )
                                .accessibilityIdentifier("ErrorMessage")
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }

                    Text("Weather")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .accessibilityIdentifier("WeatherTitle")

                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)

                        TextField("City", text: $viewModel.city)
                            .textFieldStyle(.roundedBorder)
                            .frame(height: 36)
                            .accessibilityIdentifier("CityTextField")

                        Button {
                            Task { await viewModel.fetchWeather() }
                        } label: {
                            Image(systemName: "location.fill")
                                .padding(8)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        .accessibilityIdentifier("GetWeatherButton")
                    }
                    .padding(.horizontal)

                    if viewModel.weather != nil {
                        Picker("Unit", selection: $viewModel.selectedUnit) {
                            ForEach(TemperatureUnit.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 16)
                        .accessibilityIdentifier("TemperatureUnitPicker")
                    }

                   
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.3)
                            .accessibilityIdentifier("LoadingIndicator")
                    }

                    if let weather = viewModel.weather {
                        WeatherDetailView(weather: weather, unit: viewModel.selectedUnit)
                            .padding(.horizontal)
                            .accessibilityIdentifier("WeatherDetailView")
                    }

                    Spacer()
                }
                .padding(.top, 32)

                if isMenuOpen {
                    TemperatureMenuView(isMenuOpen: $isMenuOpen)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(WeatherConstants.cornerRadius)
                        .shadow(
                            color: Color.gray.opacity(WeatherConstants.shadowOpacity),
                            radius: WeatherConstants.shadowRadius, x: 0, y: 10
                        )
                        .overlay(
                            CloseButton(action: {
                                withAnimation { isMenuOpen.toggle() }
                            })
                            .padding(20),
                            alignment: .topTrailing
                        )
                        .accessibilityIdentifier("TemperatureMenu")
                }
            }
        }
    }
}
