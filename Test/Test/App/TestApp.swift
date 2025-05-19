import SwiftUI

@main
@MainActor
struct YourApp: App {
    let viewModel = WeatherViewModel(service: WeatherServiceImpl())

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environment(viewModel)
        }
    }
}
