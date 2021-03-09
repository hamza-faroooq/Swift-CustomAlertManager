import UIKit

// MARK: - This class is used to make custom alert -

class AlertManager {
    
    static var topVCGeneric = UIViewController()
    static var leftButtonCallBackGeneric: (()->())?
    static var rightButtonCallBackGeneric: (()->())?
    
    class func customAlertView(titleString: String = ALERT, messageString: String = "", isSingleButton: Bool = true, leftButtonTitle: String = OKAY, rightButtonTitle: String = CANCEL, isDismissingDialogForFirstButton: Bool = true, isDismissingDialogForSecondButton: Bool = true, leftButtonCallBack: (()->())? = nil, rightButtonCallBack: (()->())? = nil) -> Void {
        
        // 100 tag for most outer view
        // 200 tag for outer view
        // -1 tag for first button to dismiss the alert when isDismissingDialogForFirstButton is set to true
        // -2 tag for second button to dismiss the alert when isDismissingDialogForSecondButton is set to true
        
        guard let topVC = UIApplication.topViewController() else { return }
        topVCGeneric = topVC
            
        let totalWidth = UIScreen.main.bounds.width
        let totalHeight = UIScreen.main.bounds.height
        
        // creating most outer view
        let mostOuterView = UIView(frame: CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight))
        mostOuterView.backgroundColor = .color_black
        mostOuterView.alpha = 0.5
        mostOuterView.tag = 100
        topVC.view.addSubview(mostOuterView)
        
        // creating Outer View
        let calculatedWidth = totalWidth * 0.8
        let calculatedHeight = 300
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: Int(calculatedWidth), height: calculatedHeight))
        outerView.backgroundColor = .color_white
        outerView.layer.cornerRadius = 8
        outerView.tag = 200
        topVC.view.addSubview(outerView)
            
        // creating imageView
        let spacingBetweenOuterViewAndImageViewFromTop = 16
        let totalWidthAndHeightOfImageView = 40
            
        let imageLogo = UIImageView(frame: CGRect(x: 0, y: spacingBetweenOuterViewAndImageViewFromTop, width: totalWidthAndHeightOfImageView, height: totalWidthAndHeightOfImageView))
        imageLogo.image = UIImage(named: "appLogoBackGround")
        imageLogo.contentMode = .scaleAspectFit
        outerView.addSubview(imageLogo)
        
        // creating Title Label
        let spacingBetweenImageViewAndTitleLabelFromTop = 16
        let calculatedYForTitleLabel = spacingBetweenOuterViewAndImageViewFromTop + totalWidthAndHeightOfImageView + spacingBetweenImageViewAndTitleLabelFromTop
        let heightOfTitleLabel = 20
            
        let titleLabel = UILabel(frame: CGRect(x: 0, y: calculatedYForTitleLabel, width: Int(calculatedWidth), height: heightOfTitleLabel))
        titleLabel.textAlignment = .center
        titleLabel.text = titleString
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .color_lightBluish
        titleLabel.font = UIFont(name: SharedManager.boldFont(), size: 16)
        outerView.addSubview(titleLabel)
            
        // creating Message Label
        let spacingBetweenMessageLabelAndTitleLabelFromTop = 8
        let calculatedYForMessageLabel = calculatedYForTitleLabel + heightOfTitleLabel + spacingBetweenMessageLabelAndTitleLabelFromTop
        let heightOfMessageLabel = 40
        let leftRightMarginsOfMessageLabel = 24
        let calculatedWidthForMessageLabel = calculatedWidth - CGFloat(leftRightMarginsOfMessageLabel * 2)
        
        let messageLabel = UILabel(frame: CGRect(x: CGFloat(leftRightMarginsOfMessageLabel), y: CGFloat(calculatedYForMessageLabel), width: calculatedWidthForMessageLabel, height: CGFloat(heightOfMessageLabel)))
        messageLabel.text = messageString
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = .color_black
        messageLabel.font = UIFont(name: SharedManager.demiBoldFont(), size: 14)
            
        let dynamicHeightOfMessageLabel = dynamicHeightOfLabel(text: messageLabel.text!, font: messageLabel.font, width: calculatedWidthForMessageLabel)
            
        messageLabel.frame = CGRect(x: CGFloat(leftRightMarginsOfMessageLabel), y: CGFloat(calculatedYForMessageLabel), width: calculatedWidthForMessageLabel, height: dynamicHeightOfMessageLabel)
        
        outerView.addSubview(messageLabel)
        
        // creating left right buttons using stackView
        let leftMarginOfStackView = 24
        let spacingBetweenStackViewAndMessageLabel = 32
        let calculatedYForStackView = calculatedYForMessageLabel + Int(dynamicHeightOfMessageLabel) + spacingBetweenStackViewAndMessageLabel
        let heightOfStackView = 40
        let calculatedWidthForStackView = calculatedWidth - CGFloat(leftMarginOfStackView * 2)
            
        let stackView = UIStackView(frame: CGRect(x: leftMarginOfStackView, y: calculatedYForStackView, width: Int(calculatedWidthForStackView), height: heightOfStackView))
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        //left Button
        let firstButton = UIButton()
        firstButton.layer.cornerRadius = 4
        firstButton.backgroundColor = .color_lightBluish
        firstButton.setTitle(leftButtonTitle, for: .normal)
        firstButton.titleLabel?.font = UIFont(name: SharedManager.boldFont(), size: 14)
        firstButton.setTitleColor(.color_white, for: .normal)
        firstButton.addTarget(self, action: #selector(AlertManager.firstButtonAction(sender:)), for: .touchUpInside)
        
        if isDismissingDialogForFirstButton {
            firstButton.tag = -1
        }
        
        leftButtonCallBackGeneric = leftButtonCallBack
        
        //right Button
        let secondButton = UIButton()
        secondButton.layer.cornerRadius = 4
        secondButton.backgroundColor = .color_lightBluish
        secondButton.setTitle(rightButtonTitle, for: .normal)
        secondButton.titleLabel?.font = UIFont(name: SharedManager.boldFont(), size: 14)
        secondButton.setTitleColor(.color_white, for: .normal)
        secondButton.addTarget(self, action: #selector(AlertManager.secondButtonAction(sender:)), for: .touchUpInside)
        
        if isDismissingDialogForSecondButton {
            secondButton.tag = -2
        }
         
        rightButtonCallBackGeneric = rightButtonCallBack
        
        stackView.addArrangedSubview(firstButton)
        
        if !isSingleButton {
            stackView.addArrangedSubview(secondButton)
        }
        
        outerView.addSubview(stackView)
        
        // finally calculating total height of Outer View
        let spacingBetweenStackViewAndOuterViewFromBottom = 16
        let calculatedOuterViewHeight = calculatedYForStackView + heightOfStackView + spacingBetweenStackViewAndOuterViewFromBottom
            
        outerView.frame = CGRect(x: 0, y: 0, width: calculatedWidth, height: CGFloat(calculatedOuterViewHeight))
        outerView.center = topVC.view.center
        outerView.center.y = (totalHeight / 2) - CGFloat((calculatedOuterViewHeight / 3))
        
        if totalHeight <= 568 {
        
            // for iphone SE
            imageLogo.center.x = outerView.center.x - (CGFloat(totalWidthAndHeightOfImageView) * 0.8)
            
        } else if totalHeight <= 812 {
        
            // for iphone 8, iphone x
            imageLogo.center.x = outerView.center.x - (CGFloat(totalWidthAndHeightOfImageView) * 0.95)
            
        } else if totalHeight <= 896 {
        
            // for iphone xr
            imageLogo.center.x = outerView.center.x - (CGFloat(totalWidthAndHeightOfImageView) * 1.05)
            
        } else {
        
            // for Ipad
            imageLogo.center.x = outerView.center.x - (CGFloat(totalWidthAndHeightOfImageView) * 1.9)
            
        }
        
        outerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.25, animations: {
        
            outerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }) { (completion) in
        
            UIView.animate(withDuration: 0.25, animations: {
            
                outerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            })
            
        }
        
    }
        
    @objc class func firstButtonAction(sender: UIButton) {
    
        if sender.tag == -1 {
            
            topVCGeneric.view.viewWithTag(100)?.removeFromSuperview()
            topVCGeneric.view.viewWithTag(200)?.removeFromSuperview()
            
        } else {
        
            leftButtonCallBackGeneric?()
            
        }
        
    }
    
    @objc class func secondButtonAction(sender: UIButton) {
            
        if sender.tag == -2 {
                
            topVCGeneric.view.viewWithTag(100)?.removeFromSuperview()
            topVCGeneric.view.viewWithTag(200)?.removeFromSuperview()
            
        } else {
        
            rightButtonCallBackGeneric?()
            
        }
        
    }
        
    class func dynamicHeightOfLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
            
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.textAlignment = .center
        
        label.sizeToFit()
        
        return label.frame.height
            
    }
    
}
