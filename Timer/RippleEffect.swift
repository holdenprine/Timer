//
//  RippleEffect.swift
//  Timer
//
//  Created by Holden Prine on 3/13/25.
//

import SwiftUI
import simd

struct RippleEffect: ViewModifier {
    var origin: CGPoint
    var elapsedTime: TimeInterval
    var duration: TimeInterval
    var amplitude: Double
    var frequency: Double
    var decay: Double
    var speed: Double
    
    func body(content: Content) -> some View {
        let shader = ShaderLibrary.Ripple(
            .float2(origin),
            .float(elapsedTime),
//        Params
            .float(amplitude),
            .float(frequency),
            .float(decay),
            .float(speed)
            )
        let maxSampleOffset = maxSampleOffset
        let elapsedTime = elapsedTime
        let duration = duration
        content.visualEffect {view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: 0 < elapsedTime && elapsedTime < duration
            )
        }
    }
    var maxSampleOffset: CGSize {
        CGSize(width: amplitude, height: amplitude)
    }
}

struct RippleEffectModifier<T: Equatable>: ViewModifier {
    var origin: CGPoint
    var trigger: T
    var amplitude: Double
    var frequency: Double
    var decay: Double
    var speed: Double
    
    @State private var elapsedTime: TimeInterval = 0
    @State private var startTime: Date?
    
    init(at origin: CGPoint, trigger: T, amplitude: Double = 12, frequency: Double = 15, decay: Double = 8, speed: Double = 1200) {
        self.origin = origin;
        self.trigger = trigger;
        self.amplitude = amplitude;
        self.frequency = frequency;
        self.decay = decay;
        self.speed = speed;
    }
    
    func body(content: Content) -> some View {
        content
            .modifier(
                RippleEffect(
                    origin: origin, elapsedTime: elapsedTime, duration: 2.0, amplitude: amplitude, frequency: frequency, decay: decay, speed: speed
                )
            ).onChange(of: trigger) { _ in
                startTime = Date()
                elapsedTime = 0
                withAnimation(.linear(duration: 2.0)) {
                    elapsedTime = 2.0
                }
            }
    }
}

extension View {
    func rippleEffect<T: Equatable>(at origin: CGPoint, trigger: T, amplitude: Double = 45, frequency: Double = 15, decay: Double = 8, speed: Double = 1200) -> some View {
        self.modifier(RippleEffectModifier(at: origin, trigger: trigger, amplitude: amplitude, frequency: frequency, decay: decay, speed: speed))
    }
}
