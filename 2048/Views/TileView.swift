//
//  TileView.swift
//  2048
//
//  Created by Alex Luna on 30/07/2020.
//

import SwiftUI

struct TileView: View {
    var cornerRadius: CGFloat = 10

    var tile: Tile

    var bgcolor: Color {
        switch tile.value {
        case 2:
            return Color(UIColor(red: 0.94, green: 0.89, blue: 0.85, alpha: 1.00))
        case 4:
            return Color(UIColor(red: 0.93, green: 0.88, blue: 0.78, alpha: 1.00))
        case 8:
            return Color(UIColor(red: 0.98, green: 0.68, blue: 0.45, alpha: 1.00))
        case 16:
            return Color(UIColor(red: 1.00, green: 0.55, blue: 0.35, alpha: 1.00))
        case 32:
            return Color(UIColor(red: 1.00, green: 0.42, blue: 0.33, alpha: 1.00))
        case 64:
            return Color(UIColor(red: 1.00, green: 0.25, blue: 0.12, alpha: 1.00))
        case 128:
            return Color(UIColor(red: 0.94, green: 0.82, blue: 0.41, alpha: 1.00))
        case 256:
            return Color(UIColor(red: 0.94, green: 0.82, blue: 0.34, alpha: 1.00))
        case 512:
            return Color(UIColor(red: 0.94, green: 0.80, blue: 0.25, alpha: 1.00))
        case 1024:
            return Color(UIColor(red: 0.94, green: 0.78, blue: 0.16, alpha: 1.00))
        case 2048:
            return Color(UIColor(red: 0.94, green: 0.78, blue: 0.00, alpha: 1.00))
        default:
            return Color.specialGray
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(bgcolor).opacity(0.6)
                    .cornerRadius(cornerRadius)
                    .border(Color.gray, width: 1)
                Text(String(tile.value))
                    .fontWeight(.black)
                    .font(.system(size: geometry.size.height > geometry.size.width ?
                                    geometry.size.width * 0.4: geometry.size.height * 0.4))
                    .foregroundColor(.darkGray)
                    .bold()
            }.animation(.spring())
            .overlay(
              RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(LinearGradient.diagonalDarkBorder, lineWidth: 2)
            )
            .background(Color.backgroundGray)
            .cornerRadius(cornerRadius)
            .shadow(
              color: Color(white: 1.0).opacity(0.9),
              radius: 4,
              x: -4,
              y: -4)
            .shadow(
              color: Color.shadowGray.opacity(0.5),
              radius: 2,
              x: 2,
              y: 2)
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach([2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096], id: \.self) { value in
                TileView(tile: Tile(value: value))
                    .frame(width: 100, height: 100) // Set your desired frame size here
                    .previewLayout(.sizeThatFits)
                    .padding()
                    .background(Color.white)
            }
            TileView(tile: Tile(value: 0)) // Default case
                .frame(width: 100, height: 100) // Set your desired frame size here
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.white)
        }
    }
}
