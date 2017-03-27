

import UIKit


@IBDesignable
class SoicialButton : UIControl {
    
    fileprivate lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
        return label
    }()
    
    fileprivate var spacingConstraint : NSLayoutConstraint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitialization()
    }
}


// MARK:- Public API
extension SoicialButton {
    @IBInspectable
    var image: UIImage? {
        get {
            return imageView.image
        }
        set(newImage) {
            imageView.image = newImage?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable
    var text: String? {
        get {
            return label.text
        }
        set(newText) {
            label.text = newText
        }
    }
}

extension SoicialButton {
    func sharedInitialization() {
        addSubview(label)
        addSubview(imageView)
        label.textColor = tintColor
        
        let labelviewCenterXConstraint = NSLayoutConstraint(item: label, attribute: .centerX
            , relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        let labelviewCenterYConstraint = NSLayoutConstraint(item: label, attribute: .centerY
            , relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 2)
        
        
        let imageviewLeadingAnchor =  NSLayoutConstraint(item: imageView,
                                                         attribute: .leading,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .leading,
                                                         multiplier: 1.0,
                                                         constant: 35)
        
        let imageviewCenterY =
            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0
        )
        let selfwidthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal
            , toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 315)
        
        let selfHeightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal
            , toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 55)
        
        NSLayoutConstraint.activate(
            [
                selfwidthConstraint
                ,selfHeightConstraint
                ,imageviewLeadingAnchor
                ,imageviewCenterY
                ,labelviewCenterXConstraint
                ,labelviewCenterYConstraint
            ]
        )
        layer.cornerRadius = 28
        addTapGestureRecognizer()
    }
    override func layoutSubviews() {
        
    }
}
extension SoicialButton {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        label.textColor = tintColor
    }
}
extension SoicialButton {
    fileprivate func addTapGestureRecognizer() {
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(SoicialButton.handleIconTapped(_:)))
        addGestureRecognizer(tapGestureRecogniser)
    }
    func handleIconTapped(_ sender: UITapGestureRecognizer) {
        sendActions(for: .touchUpInside)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateTintAdjustmentMode(.dimmed)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateTintAdjustmentMode(.normal)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateTintAdjustmentMode(.normal)
    }
    fileprivate func animateTintAdjustmentMode(_ mode: UIViewTintAdjustmentMode) {
        UIView.animate(withDuration: mode == .normal ? 0.3 : 0.05, animations: {
            self.tintAdjustmentMode = mode
        })
    }
    
}

