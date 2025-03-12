//
//  TimerArc.swift
//  Timer
//
//  Created by Holden Prine on 3/12/25.
//
import SwiftUI

struct TimerArc: Shape {
    
//    Represents timer progress from 0 - 1 (think some kind of percentage represented as a decimal)
    var progress: Double
//    initialized to pass lineWidth to the TimerView for correct positioning
    var lineWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startAngle = -90.0
        let endAngle = Double(progress) * 360.0 - 90.0
        
        path.addArc(center: center, radius: radius, startAngle: Angle.degrees(startAngle), endAngle: Angle.degrees(endAngle), clockwise: false)
        return path
        }
    }

