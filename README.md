# 🌦️ WeatherApp – SwiftUI MVVM Architecture

WeatherApp is a lightweight, modular SwiftUI application that displays live weather data using the [OpenWeatherMap API](https://openweathermap.org/api). Built following **MVVM**, **SOLID principles**, and **Clean Code Architecture**, this project demonstrates best practices for iOS development using SwiftUI, Async Await, and XCTest/XCUITest.

---

## 🚀 Features

- Search weather by city name
- Display current temperature, humidity, wind, and condition
- Temperature unit toggle (Celsius, Fahrenheit, Kelvin)
- Asynchronous API calls using `async/await`
- Loading, error, and success UI states
- Modular architecture with testable layers
- Unit tests for ViewModel
- UI tests using accessibility identifiers
- Accessible design with SwiftUI best practices

---

## 🧱 Architecture Overview

This project uses a **modular MVVM** structure and **Clean Architecture** principles.

### 🗂 Folder Structure

```
.
├── App/                   # App entry point and SwiftUI scene
├── CoreModules/           # Models & Enums (e.g. WeatherModel, TemperatureUnit)
├── ViewModels/            # Business logic using @Observable ViewModel
├── Views/                 # All SwiftUI views
├── Services/              # API service protocol + implementation
├── Constants/             # UI constants and theme
├── TestTests/             # Unit tests using XCTest
├── TestUITests/           # UI tests using XCUITest
```

---

## 🛠 Technologies

- **Swift**
- **SwiftUI**
- **MVVM Design Pattern**
- **async/await for Networking**
- **XCTest & XCUITest**
- **OpenWeatherMap API**

---

## 🔄 Design Patterns & Principles

- ✅ **MVVM** for UI and state management
- ✅ **SOLID Principles**
  - *Single Responsibility:* Each component does one thing.
  - *Dependency Injection:* Services injected into ViewModels.
- ✅ **Clean Architecture**
  - Clear separation between UI, domain logic, and services
- ✅ **Modular Design**
  - Components are decoupled and testable in isolation

---

## 🧪 Testing

### ✅ Unit Tests (`TestTests`)
- `WeatherViewModelTests`
  - `testSuccessfulFetch()`
  - `testFetchFailure()`
  - `testErrorClearsAfterDelay()`
  - `testFetchWithEmptyCityDoesNothing()`

### ✅ UI Tests (`TestUITests`)
- `testFetchWeatherWithCityName()`
- `testTemperaturePickerAppearsAfterWeatherLoads()`
- `testInvalidCityShowsError()`

🧪 UI tested via `accessibilityIdentifier` on key components for maintainability.

---

## 🧩 Accessibility & UX

- `accessibilityLabel` for all weather data
- `accessibilityIdentifier` for UI testing support
- Segmented control picker only appears when data is available
- Graceful handling of errors and loading indicators

---

## 🔧 Setup

1. Clone the repo:
   ```bash
   git clone git@github.com:KeycodeConsultancy/WeatherApp.git
   cd WeatherApp
   ```

2. Add your OpenWeather API key to your Info.plist:
   ```xml
   <key>OpenWeatherAPIKey</key>
   <string>YOUR_API_KEY</string>
   ```

3. Run the project on the latest iOS simulator or device.

---

