//
//  TileView.swift
//  2048
//
//  Created by Alex Luna on 30/07/2020.
//

import SwiftUI

struct TileView: View {
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
            return Color(UIColor(red: 0.24, green: 0.23, blue: 0.19, alpha: 1.00))
        }
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(bgcolor)
                .cornerRadius(15)
            Text(String(tile.value))
                .fontWeight(.black)
        }.animation(.easeInOut)
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        let tile = Tile(value: 4)
        return TileView(tile: tile)
    }
}
