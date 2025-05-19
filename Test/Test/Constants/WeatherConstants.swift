import Foundation
import SwiftUI

struct WeatherConstants {
    static let absoluteZeroInCelsius: Double = -273.15
    static let sunMinThreshold: Double = 273.15
    static let sunMaxThreshold: Double = 293.15
    static let cornerRadius: CGFloat = 20
    static let shadowRadius: CGFloat = 10
    static let shadowOpacity: Double = 0.5
    static let buttonFrame = CGSize(width: 150, height: 40)
    static let iconSize: CGFloat = 24
    static let ellipsisSize: CGFloat = 30
    static let gradientColors: [Color] = [Color.blue, Color.white]
}
