//
//  UIView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIView {
    /// Initializer method
    static public func oy_init() -> UIView {
        UIView()
    }

    /// Initializer method with `frame` value
    public static func oy_init(frame: CGRect) -> UIView {
        UIView(frame: frame)
    }

    /// Initializer method with `x, y, width, height` values
    static public func oy_init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
        UIView(frame: .oy_init(x, y, width, height))
    }

    /// Initializer method with `touchUpInside action`
    /// Usage:
    ///
    /// `let button: UIButton = UIButton.oy_init { view in
    ///     // do stuff
    /// `}
    public static func oy_init<T: OYInit>(touchUpInside: ((_ view: T) -> Void)?) -> T {
        let view = T.oy_init()
        let gesture = OYTapGesture {
            touchUpInside?(view as! T)
        }
        view.addGestureRecognizer(gesture)
        return view as! T
    }

    /// Init with `Nib` with `frame and bundle` values
    public static func oy_initWithNib<T: OYInit>(frame: CGRect, bundle: Bundle = .main) -> T {
        let nib = UINib(nibName: oy_reuseIdentifier, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("\(#function) Cannot instantiate view controller of type \(oy_reuseIdentifier)")
        }
        view.frame = frame
        return view as! T
    }

    /// Hide UIView with animation
    public func oy_hide() {
        isHidden = true
    }
    
    /// Determines whether user events are ignored and removed from the event queue
    public func oy_isEnableOrDisable(isEnable: Bool) {
        isUserInteractionEnabled = isEnable
    }

    /// Remove UIView with animation
    public func oy_remove(animated: Bool = false) {
        UIView.animate(withDuration: animated ? 0.5 : 0.0) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    /// All subviews of UIView
    var oy_allSubviews: [UIView] {
        oy_subviews(self)
    }

    /// UIView's all subviews of a given type
    public func oy_allSubviews<T>(of type: T.Type) -> [T] {
        var views = [T]()
        for subview in subviews {
            if let view = subview as? T {
                views.append(view)
            } else if !subview.subviews.isEmpty {
                views.append(contentsOf: subview.oy_allSubviews(of: T.self))
            }
        }
        return views
    }

    /// Add array of subviews to UIView
    public func oy_addSubviews(_ subviews: UIView...) {
        _ = subviews.map({ addSubview($0) })
    }
    
    /// Insert of subview with index
    public func oy_insertSubview(_ subview: UIView, index: Int) {
        insertSubview(subview, at: index)
    }

    /// Remove subviews of UIView
    public func oy_removeSubviews() {
        _ = subviews.map({ $0.removeFromSuperview() })
    }

    /// Remove all subviews of UIView
    public func oy_removeAllSubviews() {
        while subviews.count > 0 {
            subviews.last?.removeFromSuperview()
        }
    }

    /// Copy UIView
    public func oy_copy<T>() throws -> T? {
        let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }

    /// Snapshot of UIView
    @objc public var oy_snapshot: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    /// Get and Set background color of UIView
    public var oy_backgroundColor: UIColor? {
        get { backgroundColor }
        set(value) { backgroundColor = value }
    }

    /// Circle UIView
    public func oy_circle() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }

    /// Set corner radius of view
    public func oy_cornerRadius(corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.maskedCorners = corners
    }

    /// Add border to UIView
    public func oy_addBorder(color: UIColor, width: CGFloat, radius: CGFloat? = nil) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        guard let radius else { return }
        layer.cornerRadius = radius
    }

    /// Remove UIView's border
    public func oy_removeBorder(maskToBounds: Bool = true) {
        layer.borderWidth = 0
        layer.cornerRadius = 0
        layer.borderColor = nil
        layer.masksToBounds = maskToBounds
    }
    
    /// Update UIView's border with animation
    public func oy_updateBorderAnimate(color: UIColor?, width: CGFloat?, radius: CGFloat? = nil, duration: CGFloat = 0.5) {
        UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            if let color {
                self.layer.borderColor = color.cgColor
            }
            if let width {
                self.layer.borderWidth = width
            }
            if let radius {
                self.layer.cornerRadius = radius
            }
        }.startAnimation()
    }

    /// Add dashed border to UIView
    public func oy_dashedBorder(color: UIColor, width: CGFloat, radius: CGFloat) {
        let shapeLayer = CAShapeLayer()
        let shapeRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [7, 7]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: radius).cgPath

        layer.addSublayer(shapeLayer)
    }

    /// Get and Set cornerRadius for UIView
    public var oy_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /// Get and Set borderWidth for UIView
    public var oy_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// Get and Set borderColor for UIView
    public var oy_borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Global point on UIWindow of UIView
    public var oy_globalPoint: CGPoint? {
        guard let window = UIApplication.oy_keyWindow else {
            return nil
        }
        return window.convert(frame.origin, to: nil)
    }
    
    /// Global frame on UIWindow of UIView
    public var oy_globalFrame: CGRect? {
        guard let window = UIApplication.oy_keyWindow else {
            return nil
        }
        return convert(bounds, to: window)
    }
    
    /// Impact between UI elements
    public func oy_impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.impactOccurred()
    }

    /// Add UITapGestureRecognizer to UIView with completion handler
    public func oy_didTap(tapCount: Int = 1, touchCount: Int = 1, _ completion: ((UIView) -> Void)?) {
        let gesture = OYTapGesture(tapCount: tapCount, touchCount: touchCount) {
            completion?(self)
        }
        addGestureRecognizer(gesture)
    }

    /// Add UILongPressGestureRecognizer to UIView with completion handler
    public func oy_didLongPress(_ closure: ((UIView) -> Void)?) {
        let gesture = OYLongPressGesture {
            closure?(self)
        }
        addGestureRecognizer(gesture)
    }

    /// Add UISwipeGestureRecognizer to UIView with completion handler
    public func oy_didSwipe(direction: UISwipeGestureRecognizer.Direction, touchCount: Int = 1, _ completion: ((UIView) -> Void)?) {
        let gesture = OYSwipeGesture(direction: direction, touchCount: touchCount) {
            completion?(self)
        }
        addGestureRecognizer(gesture)
    }

    /// Add UIPanGestureRecognizer to UIView with completion handler
    public func oy_didPan(_ completion: ((UIView) -> Void)?) {
        let gesture = OYPanGesture {
            completion?(self)
        }
        addGestureRecognizer(gesture)
    }

    /// Add UIPinchGestureRecognizer to UIView with completion handler
    public func oy_didPinch(_ completion: ((UIView) -> Void)?) {
        let gesture = OYPinchGesture {
            completion?(self)
        }
        addGestureRecognizer(gesture)
    }

    /// Set shadow to UIView
    public func oy_setShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    /// Remove shadow of UIView
    public func oy_removeShadow(maskToBounds: Bool = true) {
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
        layer.cornerRadius = 0
        layer.shadowPath = nil
        layer.masksToBounds = maskToBounds
    }

    /// `view.oy_addGradient(colors: [.yellow, .red], direction: .leftBottomToRightTop)`
    public func oy_addGradient(colors: [UIColor], direction: AnimationHelper.GradientDirection) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds

        var gradientColors: [Any] = colors
        for index in 0 ..< colors.count {
            let currentColor: UIColor = colors[index]
            gradientColors[index] = currentColor.cgColor
        }
        gradient.colors = gradientColors

        switch direction {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)

        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)

        case .leftTopToRightBottom:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

        case .leftBottomToRightTop:
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)

        case .rightTopToLeftBottom:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)

        case .rightBottomToLeftTop:
            gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.0)

        case let .custom(startPoint, endPoint):
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
        }
        layer.insertSublayer(gradient, at: 0)
    }

    /// Make clear hole with corner radius on UIView
    public func oy_makeHole(frame: CGRect, cornerRadius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = .evenOdd
        maskLayer.fillColor = UIColor.black.cgColor

        let pathToOverlay = UIBezierPath(rect: bounds)
        pathToOverlay.append(UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius))
        pathToOverlay.usesEvenOddFillRule = true
        maskLayer.path = pathToOverlay.cgPath

        layer.mask = maskLayer
    }
    
    // MARK: - Animations
    /// Start `FadeIn` animation with duration
    public func oy_fadeIn(duration: TimeInterval = 0.5, skipSetAlphaZero: Bool = false) {
        if !skipSetAlphaZero {
            alpha = 0
        }
        
        UIView.animate(withDuration: duration) {
            self.alpha = 1
        }
    }

    /// Start `FadeOut` animation with duration
    public func oy_fadeOut(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        }
    }

    /// Start `Rotate` animation
    public func oy_rotateAnimation(duration: TimeInterval) {
        guard layer.animation(forKey: AnimationHelper.rotateKey) == nil else { return }

        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0.0
        animation.toValue = Float.pi * 2.0
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: AnimationHelper.rotateKey)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.oy_stopRotateAnimation()
        }
    }

    /// Stop `Rotate` animation
    public func oy_stopRotateAnimation() {
        oy_stopAnimation(for: AnimationHelper.rotateKey)
    }

    /// Start `Shake` animation
    public func oy_shakeAnimation(duration: TimeInterval, repeatCount: Int) {
        guard layer.animation(forKey: AnimationHelper.shakeKey) == nil else { return }

        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = [NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0)), NSValue(caTransform3D: CATransform3DMakeTranslation(5, 0, 0))
        ]
        animation.autoreverses = true
        animation.repeatCount = Float(repeatCount)
        animation.duration = duration
        layer.add(animation, forKey: AnimationHelper.shakeKey)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.oy_stopShakeAnimation()
        }
    }

    /// Stop `Shake` animation
    public func oy_stopShakeAnimation() {
        oy_stopAnimation(for: AnimationHelper.shakeKey)
    }

    /// Start `Flash` animation
    public func oy_flashAnimation(duration: TimeInterval, repeatCount: Float) {
        guard layer.animation(forKey: AnimationHelper.opacityKey) == nil else { return }

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = repeatCount
        layer.add(animation, forKey: AnimationHelper.opacityKey)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.oy_stopFlashAnimation()
        }
    }

    /// Stop `Flash` animation
    public func oy_stopFlashAnimation() {
        oy_stopAnimation(for: AnimationHelper.opacityKey)
    }

    /// Start `Heart` animation
    public func oy_heartAnimation(duration: TimeInterval) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.fromValue = 1.0
        pulse.toValue = 1.2
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 0.8
        layer.add(pulse, forKey: AnimationHelper.heartKey)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.oy_stopHeartAnimation()
        }
    }

    /// Stop `Heart` animation
    public func oy_stopHeartAnimation() {
        oy_stopAnimation(for: AnimationHelper.heartKey)
    }

    /// Start `Flip` animation
    public func oy_flipAnimation(duration: TimeInterval, direction: AnimationHelper.FlipDirection, autoReverse: Bool = false) {
        guard layer.animation(forKey: AnimationHelper.flipKey) == nil else { return }

        let animation = CATransition()
        animation.subtype = CATransitionSubtype(rawValue: direction.rawValue)
        animation.startProgress = 0
        animation.endProgress = 1.0
        animation.type = CATransitionType(rawValue: "flip")
        animation.duration = duration
        animation.repeatCount = 1
        animation.autoreverses = autoReverse
        layer.add(animation, forKey: AnimationHelper.flipKey)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.oy_stopFlipAnimation()
        }
    }

    /// Stop `Flip` animation
    public func oy_stopFlipAnimation() {
        oy_stopAnimation(for: AnimationHelper.flipKey)
    }
}

extension UIView {
    /// Private methods for find all subviews
    private func oy_subviews(_ parent: UIView, level: Int = 0) -> [UIView] {
        var result = [UIView]()
        for subview in parent.subviews {
            result.append(subview)
            if subview.subviews.isEmpty { continue }
            result += oy_subviews(subview, level: level + 1)
        }
        return result
    }
}

// MARK: - Animations Constants
extension UIView {
    public struct AnimationHelper {
        static let flipKey = "oy_flip_animation_key"
        static let heartKey = "oy_heart_animation_key"
        static let opacityKey = "oy_opacity_animation_key"
        static let rotateKey = "oy_rotate_animation_key"
        static let shakeKey = "oy_shake_animation_key"

        public enum GradientDirection {
            case horizontal
            case vertical
            case leftBottomToRightTop
            case leftTopToRightBottom
            case rightBottomToLeftTop
            case rightTopToLeftBottom
            case custom(startPoint: CGPoint, endPoint: CGPoint)
        }

        public enum FlipDirection: String {
            case fromTop
            case fromBottom
            case fromLeft
            case fromRight
        }
    }

    private func oy_stopAnimation(for key: String) {
        guard layer.animation(forKey: key) != nil else { return }
        layer.removeAnimation(forKey: key)
    }
}
