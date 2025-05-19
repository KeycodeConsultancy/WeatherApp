import XCTest
@testable import Test

@MainActor
final class WeatherViewModelTests: XCTestCase {
    func testSuccessfulFetch() async {
        let mockService = MockWeatherService()
        let viewModel = WeatherViewModel(service: mockService)
        viewModel.city = "London"
        
        await viewModel.fetchWeather()
        
        XCTAssertNotNil(viewModel.weather)
        XCTAssertEqual(viewModel.weather?.name, "London")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchFailure() async {
        let mockService = MockWeatherService()
        mockService.shouldFail = true
        let viewModel = WeatherViewModel(service: mockService)
        viewModel.city = "Nowhere"
        
        await viewModel.fetchWeather()
        
        XCTAssertNil(viewModel.weather)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testErrorClearsAfterDelay() async throws {
        let mockService = MockWeatherService()
        mockService.shouldFail = true
        let viewModel = WeatherViewModel(service: mockService)
        viewModel.city = "Nowhere"

        await viewModel.fetchWeather()

        XCTAssertNotNil(viewModel.errorMessage)

    
        try await Task.sleep(nanoseconds: 5_100_000_000)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchWithEmptyCityDoesNothing() async {
        let mockService = MockWeatherService()
        let viewModel = WeatherViewModel(service: mockService)
        viewModel.city = "  " // Only spaces
        
        await viewModel.fetchWeather()
        
        XCTAssertNil(viewModel.weather)
        XCTAssertFalse(viewModel.isLoading)
    }
}
