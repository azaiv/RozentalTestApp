import UIKit

class CustomButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.transform = self.isHighlighted ? .init(scaleX: 0.94, y: 0.94) : .identity
            }
        }
    }
    
    init(title: String, 
         systemImage: String? = nil) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        if systemImage != nil {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .default)
            setImage(.init(systemName: systemImage!,
                           withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate), for: .normal)
            setImage(.init(systemName: systemImage!,
                           withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        }
        
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInsets() {
        
        let titleImageSpace: CGFloat = 5
        
        contentEdgeInsets = .init(top: 10, left: 14, bottom: 10, right: 14 + titleImageSpace)
        sizeToFit()

        let titleWidth = titleLabel?.frame.width ?? .zero
        self.imageEdgeInsets = .init(top: 0, left: -titleImageSpace /*titleWidth + titleImageSpace*/, bottom: 0, right: titleImageSpace)
    }
}
