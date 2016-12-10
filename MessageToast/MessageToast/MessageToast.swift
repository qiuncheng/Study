//
//  MessageToast.swift
//  MessageToast
//
//  Created by 程庆春 on 2016/12/8.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit

public enum MessageToastStyle {
    case onStatusBar
    case belowStatusBar
    case onNavigationBar
    case onTabbar
}

public enum MessageToastShowStyle {
    case top
    case bottom
    case left
    case right
}

public enum MessageToastType: String {
    case info = "notice_bar_info"
    case attention = "notice_bar_attention"
    case success = "notice_bar_success"
    case error = "notice"
}

extension MessageToastType {
    fileprivate var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.currentBundle(), compatibleWith: nil)
    }
    fileprivate var defaultConfig: MessageToastConfig {

        var config: MessageToastConfig
        switch self {
        case .info:
            config = MessageToastConfig(title: nil, image: self.image, textColor: UIColor.black, backgroundColor: UIColor.white, style: MessageToastStyle.onNavigationBar, showStyle: MessageToastShowStyle.top)
            break
        case .success:
            config = MessageToastConfig(title: nil, image: self.image, textColor: UIColor.black, backgroundColor: UIColor(white: 1.0, alpha: 1.0), style: MessageToastStyle.onNavigationBar, showStyle: MessageToastShowStyle.top)
            break
        case .error:
            config = MessageToastConfig(title: nil, image: self.image, textColor: UIColor.white, backgroundColor: UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0), style: MessageToastStyle.onNavigationBar, showStyle: MessageToastShowStyle.top)
        case .attention:
            config = MessageToastConfig(title: nil, image: self.image, textColor: UIColor.white, backgroundColor: UIColor.orange, style: MessageToastStyle.onNavigationBar, showStyle: MessageToastShowStyle.top)

        }
        return config
    }

    fileprivate func statusBarStyles(status: UIStatusBarStyle) -> [UIStatusBarStyle] {
        switch (status, self) {
        case (.default, .error):
            return [.lightContent, .default]

        case (.default, .info):
            return [.default, .default]

        case (.default, .success):
            return [.default, .default]

        case (.default, .attention):
            return [.lightContent, .default]

        case (.lightContent, .error):
            return [.lightContent, .lightContent]

        case (.lightContent, .info):
            return [.default, .lightContent]

        case (.lightContent, .success):
            return [.default, .lightContent]

        case (.lightContent, .attention):
            return [.lightContent, .lightContent]

        default:
            return [status, status]
        }
    }
}

extension MessageToastShowStyle {

    fileprivate func messageToastViewTransform(with frame: CGRect, _ style: MessageToastStyle) -> CGAffineTransform {
        var transform = CGAffineTransform.identity

        switch (style, self) {
        case (.onStatusBar, .top):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.belowStatusBar, .top):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onNavigationBar, .top):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onTabbar, .top):
            transform = CGAffineTransform(translationX: 0, y: frame.height)
            break
        case (.onStatusBar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.belowStatusBar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onNavigationBar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onTabbar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: frame.height)
            break
        case (.onStatusBar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.belowStatusBar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.onNavigationBar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.onTabbar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.onStatusBar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        case (.belowStatusBar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        case (.onNavigationBar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        case (.onTabbar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        }

        return transform
    }
}


extension MessageToastStyle {

    fileprivate func messageToastProperties() -> MessageProperties {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        var properties: MessageProperties
        switch self {
        case .onNavigationBar:
            properties = MessageProperties(shadowOffsetY: 3, fontSizeScaleFactor: 0.55, textFont: UIFont.systemFont(ofSize: 18), viewFrame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: 64.0)))
            break
        case .onStatusBar:
            properties = MessageProperties(shadowOffsetY: 2, fontSizeScaleFactor: 0.75, textFont: UIFont.systemFont(ofSize: 13), viewFrame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: 20.0)))
            break
        case .onTabbar:
            properties = MessageProperties(shadowOffsetY: -3, fontSizeScaleFactor: 0.55,textFont: UIFont.systemFont(ofSize: 17), viewFrame: CGRect(origin: CGPoint(x: 0, y: screenHeight - 49.0), size: CGSize(width: screenWidth, height: 49.0)))
            break
        case .belowStatusBar:
            properties = MessageProperties(shadowOffsetY: 2, fontSizeScaleFactor: 0.75, textFont: UIFont.systemFont(ofSize: 13), viewFrame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: 40.0)))
        }

        return properties

    }

    fileprivate func messageToastOriginY(superViewHeight: CGFloat, _ height: CGFloat) -> CGFloat {
        var originY: CGFloat = 0
        switch self {
        case .onNavigationBar:
            originY = (superViewHeight - height) * 0.5 + 10
            break
        case .onStatusBar:
            originY = (superViewHeight - height) * 0.5
            break
        case .onTabbar:
            originY = (superViewHeight - height) * 0.5
            break
        case .belowStatusBar:
            originY = (superViewHeight * 0.5 - height) * 0.5 + superViewHeight * 0.5
        }
        return originY
    }
    fileprivate var beginWindowLevel: UIWindowLevel {
        switch self {
        case .onStatusBar:
            return UIWindowLevelStatusBar + 1
        default:
            return UIWindowLevelNormal
        }
    }
    fileprivate var endWindowLevel: UIWindowLevel {
        return UIWindowLevelNormal
    }

}

fileprivate struct MessageProperties {
    init() { }
    var shadowOffsetY: CGFloat = 0
    var fontSizeScaleFactor: CGFloat = 0
    var textFont = UIFont()
    var viewFrame = CGRect.zero
    init(shadowOffsetY: CGFloat, fontSizeScaleFactor: CGFloat, textFont: UIFont, viewFrame: CGRect) {
        self.shadowOffsetY = shadowOffsetY
        self.fontSizeScaleFactor = fontSizeScaleFactor
        self.textFont = textFont
        self.viewFrame = viewFrame
    }
}

public struct MessageToastConfig {
    public init() { }

    public var title: String?
    public var image: UIImage? = nil
    public var margin: CGFloat = 10.0
    public var textColor: UIColor = UIColor.white
    public var backgroundColor = UIColor()
    public var animationStyle = MessageToastShowStyle.top
    public var toastStyle = MessageToastStyle.onNavigationBar

    public init(title: String?, image: UIImage?, textColor: UIColor, backgroundColor: UIColor, style: MessageToastStyle, showStyle: MessageToastShowStyle) {
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.toastStyle = style
        self.animationStyle = showStyle
    }
}

open class MessageToast: UIView {

    private var config = MessageToastConfig()

    open var type: MessageToastType?

    open var titleLabel: UILabel? {
        return _titleLabel
    }


    open var imageView: UIImageView? {
        return _imageView
    }


    private var _titleLabel: UILabel?
    private var _imageView: UIImageView?

    open func show(duration: TimeInterval, completed: @escaping (_ finished: Bool) -> Void) {
        let appStatusBarStyle = UIApplication.shared.statusBarStyle
        self.show(duration: duration, willShow: {
            [weak self] in
            guard let strongSelf = self else { return }
            let currentWindowLevel = strongSelf.config.toastStyle.beginWindowLevel
            UIApplication.shared.keyWindow?.windowLevel = currentWindowLevel
            if let type = strongSelf.type {
                let currentStatusBarStyle = type.statusBarStyles(status: appStatusBarStyle).first
                UIApplication.shared.statusBarStyle = currentStatusBarStyle!
            }
        }, completed: {
           [weak self] (finished) in
            guard let strongSelf = self else { return }
            completed(finished)
            if finished {
                let currentWindowLevel = strongSelf.config.toastStyle.endWindowLevel
                UIApplication.shared.keyWindow?.windowLevel = currentWindowLevel
                if let type = strongSelf.type {
                    let currentStatusBarStyle = type.statusBarStyles(status: appStatusBarStyle).last
                    UIApplication.shared.statusBarStyle = currentStatusBarStyle!
                }
            }

        })
    }

    public convenience init(title: String?, type: MessageToastType ) {

        var config = type.defaultConfig
        config.title = title

        self.init(config: config)
        self.type = type
    }
    public convenience init(title: String?, textColor: UIColor, background: UIColor) {
        var config = MessageToastConfig()
        config.title = title
        config.textColor = textColor
        config.backgroundColor = background
        self.init(config: config)
    }

    public convenience init(title: String?, textColor: UIColor, image: UIImage?, background: UIColor) {

        var config = MessageToastConfig()
        config.title = title
        config.textColor = textColor
        config.image = image
        config.backgroundColor = background
        self.init(config: config)

    }

    public init(config: MessageToastConfig) {
        super.init(frame: config.toastStyle.messageToastProperties().viewFrame)
        self.backgroundColor = config.backgroundColor

        self.config = config

        self.layer.shadowOffset = CGSize(width: 0, height: config.toastStyle.messageToastProperties().shadowOffsetY)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.44

        configSubviews()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configSubviews() {
        /// initial label
        _titleLabel = UILabel()
        _titleLabel?.text = config.title
        _titleLabel?.textColor = config.textColor
        _titleLabel?.minimumScaleFactor = config.toastStyle.messageToastProperties().fontSizeScaleFactor
        _titleLabel?.adjustsFontSizeToFitWidth = true
        _titleLabel?.font = config.toastStyle.messageToastProperties().textFont
        addSubview(_titleLabel!)

        var titleLabelOriginX: CGFloat = 0
        var titleLabelOriginY: CGFloat = 0
        var titleLabelHeight: CGFloat = 0
        var titleLabelWidth: CGFloat = 0


        if let _image = config.image,
            config.toastStyle != .onStatusBar,
            config.toastStyle != .belowStatusBar {

            /// initial imageView
            _imageView = UIImageView(image: _image)
            _imageView?.contentMode = .scaleAspectFill
            addSubview(_imageView!)

            let imageViewWidth: CGFloat = 25
            let imageViewOriginX = config.margin + 10
            let imageViewOriginY = config.toastStyle.messageToastOriginY(superViewHeight: frame.height, imageViewWidth)
            _imageView?.frame = CGRect(origin: CGPoint(x: imageViewOriginX, y: imageViewOriginY),
                                       size: CGSize(width: imageViewWidth, height: imageViewWidth))

            titleLabelOriginX = _imageView!.frame.maxX + config.margin
            titleLabelOriginY = _imageView!.frame.origin.y
            titleLabelHeight = _imageView!.frame.size.height
            titleLabelWidth = UIScreen.main.bounds.width - titleLabelOriginX - config.margin
            _titleLabel?.textAlignment = NSTextAlignment.left

        } else {
            _titleLabel?.textAlignment = NSTextAlignment.center
            titleLabelHeight = 30
            titleLabelWidth = UIScreen.main.bounds.width - 2 * config.margin
            titleLabelOriginX = config.margin
            titleLabelOriginY = config.toastStyle.messageToastOriginY(superViewHeight: frame.height, titleLabelHeight)
        }

        _titleLabel?.frame = CGRect(x: titleLabelOriginX, y: titleLabelOriginY, width: titleLabelWidth, height: titleLabelHeight)
    }

    private func show(duration: TimeInterval, willShow: (Void) -> Void, completed: @escaping (_ finished: Bool) -> Void) {

        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for view in subviews {
                if view.isKind(of: MessageToast.self) {
                    return
                }
            }
        }
        willShow()

        UIApplication.shared.keyWindow?.addSubview(self)
        self.transform = config.animationStyle.messageToastViewTransform(with: frame, self.config.toastStyle)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.92, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.transform = CGAffineTransform.identity
            }, completion: {
                (finished: Bool) in
                if (finished) {

                    let afterQueue = DispatchQueue(label: "com.qiuncheng.MessageToast")
                    let delayTime = DispatchTime.now() + duration
                    afterQueue.asyncAfter(deadline: delayTime, execute: {
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let strongSelf = self else { return }
                            /// dismiss
                            UIView.animate(withDuration: 0.4, animations: {
                                strongSelf.transform = strongSelf.config.animationStyle.messageToastViewTransform(with: strongSelf.frame, strongSelf.config.toastStyle)

                            }, completion: { (finished) in
                                completed(finished)
                                if (finished) {
                                    strongSelf.removeFromSuperview()
                                }
                            })
                        }
                    })
                }
        })
    }

}
