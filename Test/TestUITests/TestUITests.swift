import XCTest

final class TestUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testFetchWeatherWithCityName() throws {
        let cityField = app.textFields["CityTextField"]
        XCTAssertTrue(cityField.exists)

        cityField.tap()
        cityField.typeText("London")

        let fetchButton = app.buttons["GetWeatherButton"]
        XCTAssertTrue(fetchButton.exists)
        fetchButton.tap()
    }
    
    func testTemperaturePickerAppearsAfterWeatherLoads() throws {
        let cityField = app.textFields["CityTextField"]
        cityField.tap()
        cityField.typeText("New York")

        let fetchButton = app.buttons["GetWeatherButton"]
        fetchButton.tap()

        let picker = app.segmentedControls["TemperatureUnitPicker"]
        XCTAssertTrue(picker.waitForExistence(timeout: 5))
    }

    func testInvalidCityShowsError() throws {
        let cityField = app.textFields["CityTextField"]
        cityField.tap()
        cityField.typeText("InvalidCity123456")

        app.buttons["GetWeatherButton"].tap()

        let errorLabel = app.staticTexts["ErrorMessage"]
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 3))
    }
}
