import SwiftUI
import simd
import CoreGraphics
import AsyncGraphics
import PixelColor

protocol GraphicValue: Codable {
    
    static var zero: Self { get }
    static var one: Self { get }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self
    
    func scaled(by scale: CGFloat) -> Self
}

extension Bool: GraphicValue {
    
    static var zero: Self { false }
    static var one: Self { true }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        fraction > 0.0 ? trailing : leading
    }
    
    func scaled(by scale: CGFloat) -> Self {
        self
    }
}

extension Int: GraphicValue {
    
    static var zero: Self { 0 }
    static var one: Self { 1 }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        Int(lerp(at: fraction, from: Double(leading), to: Double(trailing)))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        Int(Double(self).multiplied(by: multiplier))
    }
}

extension Double: GraphicValue {
    
    static var zero: Self { 0.0 }
    static var one: Self { 1.0 }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        leading * (1.0 - fraction) + trailing * fraction
    }
    
    func scaled(by scale: CGFloat) -> Self {
        self * multiplier
    }
}

extension Angle: GraphicValue {
    
    static var zero: Self { .zero }
    static var one: Self { .degrees(360) }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        .degrees(lerp(at: fraction, from: leading.degrees, to: trailing.degrees))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        .degrees(degrees.multiplied(by: multiplier))
    }
}

extension CGSize: GraphicValue {
    
    static var zero: Self { .zero }
    static var one: Self { CGSize(width: 1.0, height: 1.0) }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        CGSize(width: lerp(at: fraction, from: leading.width, to: trailing.width),
               height: lerp(at: fraction, from: leading.height, to: trailing.height))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        CGSize(width: width.scaled(by: scale),
               height: height.scaled(by: scale))
    }
}

extension CGPoint: GraphicValue {
    
    static var zero: Self { .zero }
    static var one: Self { CGPoint(x: 1.0, y: 1.0) }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        CGPoint(x: lerp(at: fraction, from: leading.x, to: trailing.x),
                y: lerp(at: fraction, from: leading.y, to: trailing.y))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        CGPoint(x: x.scaled(by: scale),
                y: y.scaled(by: scale))
    }
}

extension CGRect: GraphicValue {
    
    static var zero: Self { .zero }
    static var one: Self { CGRect(origin: .zero, size: .one) }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        CGRect(origin: lerp(at: fraction, from: leading.origin, to: trailing.origin),
               size: lerp(at: fraction, from: leading.size, to: trailing.size))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        CGRect(origin: origin.scaled(by: scale),
               size: size.scaled(by: scale))
    }
}

extension PixelColor: GraphicValue {
   
    static var zero: Self { .clear }
    static var one: Self { .white }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        PixelColor(red: lerp(at: fraction, from: leading.red, to: trailing.red),
                   green: lerp(at: fraction, from: leading.green, to: trailing.green),
                   blue: lerp(at: fraction, from: leading.blue, to: trailing.blue),
                   alpha: lerp(at: fraction, from: leading.alpha, to: trailing.alpha))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        PixelColor(red: red.scaled(by: scale),
                   green: green.scaled(by: scale),
                   blue: blue.scaled(by: scale),
                   alpha: alpha.scaled(by: scale))
    }
}

extension SIMD3<Int>: GraphicValue {
    
    static var zero: Self { .zero }
    static var one: Self { .one }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        SIMD3<Int>(lerp(at: fraction, from: leading.x, to: trailing.x),
                   lerp(at: fraction, from: leading.y, to: trailing.y),
                   lerp(at: fraction, from: leading.z, to: trailing.z))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        SIMD3<Int>(x.scaled(by: scale),
                   y.scaled(by: scale),
                   z.scaled(by: scale))
    }
}

extension SIMD3<Double>: GraphicValue {
  
    static var zero: Self { .zero }
    static var one: Self { .one }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        SIMD3<Double>(lerp(at: fraction, from: leading.x, to: trailing.x),
                      lerp(at: fraction, from: leading.y, to: trailing.y),
                      lerp(at: fraction, from: leading.z, to: trailing.z))
    }
    
    func scaled(by scale: CGFloat) -> Self {
        SIMD3<Double>(x.scaled(by: scale),
                      y.scaled(by: scale),
                      z.scaled(by: scale))
    }
}

extension [Graphic.GradientStop]: GraphicValue {
    
    static var zero: Self { [] }
    static var one: Self {
        [
            .init(at: 0.0, color: .clear),
            .init(at: 1.0, color: .white)
        ]
    }
    
    static func lerp(at fraction: CGFloat, from leading: Self, to trailing: Self) -> Self {
        if leading.count == trailing.count {
            var gradient: Self = []
            for (leading, trailing) in zip(leading, trailing) {
                let stop = Graphic.GradientStop(
                    at: lerp(at: fraction, from: leading.location, to: trailing.location),
                    color: lerp(at: fraction, from: leading.color, to: trailing.color))
                gradient.append(stop)
            }
            return gradient
        }
        return leading
    }
    
    func scaled(by scale: CGFloat) -> Self {
        var gradient: Self = []
        for stop in self {
            let stop = Graphic.GradientStop(
                at: stop.location.scaled(by: scale),
                color: stop.color.scaled(by: scale))
            gradient.append(stop)
        }
        return gradient
    }
}
