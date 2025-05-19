import SwiftUI

public struct CloseButton: View {
    let action: () -> Void

    public var body: some View {
        Button(action: action) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: WeatherConstants.iconSize, height: WeatherConstants.iconSize)
                .foregroundColor(.red)
        }
    }
}
