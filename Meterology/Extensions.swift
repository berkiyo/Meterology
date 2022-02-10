//
//  Extensions.swift
//  Meterology
//
//  Created by Berk Dogan on 11/2/2022.
//

import SwiftUI
import Foundation
import UIKit

// For rounding purposes
extension Double {
	func roundDouble() -> String {
		return String(format: "%.0f", self)
	}
}

// For the information section of our app (bottom part)
extension View {
	func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
		clipShape(RoundedCorner(radius: radius, corners: corners))
	}
}

struct RoundedCorner: Shape {
	var radius: CGFloat = .infinity
	var corners: UIRectCorner = .allCorners
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		return Path(path.cgPath)
	}
}