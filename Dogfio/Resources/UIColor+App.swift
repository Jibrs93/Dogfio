//
//  UIColor+App.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 03/06/25.
//

import UIKit

// MARK: Hex Color
extension UIColor {
    static let appBackground = UIColor(hex: "#F8F8F8")
    static let textPrimary = UIColor(hex: "#333333")
    static let textSecondary = UIColor(hex: "#666666")
    static let konfioColor = UIColor(hex: "#7D28DB") // Brand
    
    convenience init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") { hex.removeFirst() }
        
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
