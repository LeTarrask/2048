//
//  View+InverseMask.swift
//  2048
//
//  Created by Alex Luna on 03/08/2020.
//

import SwiftUI

extension View {
  // 1
  func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
    // 2
    self.mask(mask
      // 3
      .foregroundColor(.black)
      // 4
      .background(Color.white)
      // 5
      .compositingGroup()
      // 6
      .luminanceToAlpha()
    )
  }
}
