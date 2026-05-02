//
//  LZComplex.swift
//  ComplexTest
//
//  Created by Luca Zapparoli on 28/8/23.
//

import Foundation

/// The struct LZComplex, together with the global funtions defined in the package and the LZComplex extension where the most important operators are overloaded, handles the math of complex numbers.
/// ```
/// var c = LZComplex(re: 2, im: 4)
///
/// print(c) // gives 2 + 4i
///
/// List of operations:
///
/// 1.  c** // gives the square of c
/// 2.  log(c) // natural log of c
/// 3.  c^3 // power 3 of c
/// 4.  c1^c2 // powr c2 of c1
/// 5.  c1 + c2
/// 6.  c1 - c2
/// 7.  c1 * c2
/// 8.  c1 / c2
/// 9.  -c1
/// 10. abs(c) // modulus of c
/// 11. sqrt(c) // root square of c
/// 12. c* // coniugate of c
/// 13. c1 += c2 // c1 = c1 + c2
/// 14. c1 -= c2 // c1 = c1 - c2
/// 15. c1 *= c2 // c1 = c1 * c2
/// 16. c1 /= c2 // c1 = c1 / c2
/// ```

public struct LZComplex: CustomStringConvertible, Equatable  {
    
    private var real: Double
    private var imaginary: Double
    
    public init() {
        self.init(re:0,im:0)
    }
    
    public init(_ re:Double) {
        self.init(re: re, im: 0)
    }
    
    public init(im: Double) {
        self.init(re: 0, im: im)
    }
    
    public init(rho: Double, theta: Double) {
        self.init(re: rho * cos(theta), im: rho * sin(theta))
    }

    public init(re: Double, im: Double) {
        self.real = re
        self.imaginary = im
    } // Designated initializer
    
    public var description: String {
        
        var sign = "+"
        if real == 0 && imaginary != 0 {
            return "\(imaginary)i"
        }
        if imaginary == 0 && real != 0 {
            return "\(real)"
        }
        if real == 0 && imaginary == 0 {
            return "0"
        }
        if imaginary < 0 {
            sign = "-"
        }
        
        return "\(real) \(sign) \(abs(imaginary))i"
    }
    
    public var re: Double {
        get {
          return real
        }
      
        set {
          real = newValue
        }
    }
    
    public var im: Double {
        get {
          return imaginary
        }
        set {
          imaginary = newValue
        }
    }
    
    public var rho: Double {
        get {
            return sqrt(pow(real, 2)+pow(imaginary,2))
        }
        set {
            let theta = self.theta
            real = newValue * cos(theta)
            imaginary = newValue * sin(theta)
        }
    }
    
    public var theta: Double {
        get {
            return atan2(imaginary,real)
        }
        set {
            let rho = self.rho
            real = rho * cos(newValue)
            imaginary = rho * sin(newValue)
        }
    }
    
    
    
}



// MARK: - GLOBAL COMPLEX FUNCTIONS
public func toDouble(_ c: LZComplex) -> Double? {
    guard c.im == 0 else {return nil}
    return c.re
}

private func coniugate(_ c: LZComplex) -> LZComplex {
    return LZComplex(re: c.re, im: -c.im)
}

public func modulus(_ c: LZComplex) -> Double {
    return sqrt(pow(c.re,2) + pow(c.im,2))
}

public func sqRoot(_ c: LZComplex) -> LZComplex {
    return c^0.5
}

/// Returns the principal natural logarithm of a complex number.
///
/// For a complex number `z = rho * e^(i * theta)`, this function returns
/// `ln(z) = ln(rho) + i * theta`, where `theta` is the principal argument
/// returned by `atan2`, normally in the interval `[-pi, pi]`.
///
/// - Important: The complex logarithm is multi-valued in theory. This function
///   returns only the principal value.
/// - Note: `ln(0)` is mathematically undefined. Since this type is based on
///   `Double`, calling `ln(LZComplex())` follows IEEE floating-point behavior
///   and produces a real part of negative infinity.
public func ln(_ c: LZComplex) -> LZComplex {
    return LZComplex(re: log(c.rho), im: c.theta)
}

/// Returns the complex exponential of a complex number.
///
/// For `z = a + bi`, the complex exponential is:
///
/// `exp(z) = e^a * (cos(b) + i * sin(b))`
///
/// This is the inverse operation of the principal complex logarithm for values
/// where the principal branch is applicable.
public func exp(_ c: LZComplex) -> LZComplex {
    let magnitude = Foundation.exp(c.re)
    return LZComplex(re: magnitude * cos(c.im), im: magnitude * sin(c.im))
}

// MARK: - OPERATORS
infix operator ^: BitwiseShiftPrecedence
postfix operator **
postfix operator *
public extension LZComplex {
    
    static func + (left: LZComplex, right: LZComplex) -> LZComplex {
        return LZComplex(re: left.re + right.re, im: left.im + right.im)
    }
    
   static func - (left: LZComplex, right: LZComplex) -> LZComplex {
        return LZComplex(re: left.re - right.re, im: left.im - right.im)
    }
    
   static prefix func - (complex: LZComplex) -> LZComplex {
        return LZComplex(re: -complex.re, im: -complex.im)
    }
    
   static func += (left: inout LZComplex, right: LZComplex) {
        left = left + right
    }
    
    static func -= (left: inout LZComplex, right: LZComplex) {
        left = left - right
    }
    
    
    // COMPLETE THE FOLLOWING OPERATIONS
    static func * (left: LZComplex, right: LZComplex) -> LZComplex {
        return LZComplex(re: left.re * right.re - left.im * right.im, im: left.re * right.im + left.im * right.re)
    }
    static func *= (left: inout LZComplex, right: LZComplex) {
        left = left * right
    }
    
    static func / (left: LZComplex, right: LZComplex) -> LZComplex {
            let denominator = right.re * right.re + right.im * right.im
            return LZComplex(re: (left.re * right.re + left.im * right.im) / denominator, im: (left.im * right.re - left.re * right.im) / denominator)
        }
    static func /= (left: inout LZComplex, right: LZComplex) {
        left = left / right
    }
    
   
    /// Raises a complex number to an integer power.
    ///
    /// This overload implements repeated multiplication for integer exponents:
    ///
    /// - `base ^ 0` returns `1 + 0i`.
    /// - `base ^ 1` returns `base`.
    /// - `base ^ n`, for `n > 1`, returns `base` multiplied by itself `n` times.
    /// - `base ^ -n`, for `n > 0`, returns `1 / (base ^ n)`.
    ///
    /// - Important: `0 ^ 0` returns `1 + 0i`, following the common programming
    ///   convention for exponentiation identities. Negative powers of zero follow
    ///   the existing division behavior of this library and may produce infinite
    ///   or NaN `Double` values.
    static func ^ (base: LZComplex, power: Int) -> LZComplex {
        if power == 0 {
            return LZComplex(1)
        }
        
        if power < 0 {
            return LZComplex(1) / (base ^ abs(power))
        }
        
        var result = LZComplex(1)
        for _ in 0..<power {
            result *= base
        }
        return result
    }
    
    static postfix func ** (c: LZComplex) -> LZComplex {
        return LZComplex(re: (c.re * c.re) - (c.im * c.im), im: 2 * c.re * c.im)
    }
    
    static postfix func * (c:LZComplex) -> LZComplex {
        return coniugate(c)
    }
    
    /// Raises a complex number to a real `Double` power.
    ///
    /// This overload uses the polar representation of the base:
    ///
    /// `z = rho * e^(i * theta)`
    ///
    /// and computes:
    ///
    /// `z^p = rho^p * e^(i * p * theta)`
    ///
    /// where `theta` is the principal argument of the base.
    ///
    /// - Important: For non-integer powers, complex exponentiation is generally
    ///   multi-valued. This overload returns the principal value only.
    /// - Note: For integer exponents, prefer the `Int` overload because it gives
    ///   exact exponentiation by repeated multiplication and avoids branch-cut
    ///   surprises.
    static func ^ (base: LZComplex, power: Double) -> LZComplex {
            let magnitude = pow(base.re * base.re + base.im * base.im, power / 2)
            let angle = atan2(base.im, base.re) * power
            return LZComplex(re: magnitude * cos(angle), im: magnitude * sin(angle))
        }
    
    /// Raises a complex number to a complex power.
    ///
    /// This overload computes the principal value using:
    ///
    /// `base ^ power = exp(power * ln(base))`
    ///
    /// where `ln(base)` is the principal complex logarithm.
    ///
    /// - Important: Complex exponentiation is multi-valued in theory because the
    ///   complex logarithm is multi-valued. This overload returns only the
    ///   principal value.
    /// - Note: If `base` is zero, the result follows the IEEE floating-point
    ///   behavior produced by `ln(0)` and the subsequent arithmetic operations.
    static func ^ (base: LZComplex, power: LZComplex) -> LZComplex {
            return exp(power * ln(base))
        }
    
    
}



