import UIKit

final class ButtonCell: UICollectionViewCell {
    
    static let stringID = "ButtonCell"
    
    private lazy var allServiceButton: CustomButton = {
        let button = CustomButton(title: "Все сервисы")
        button.backgroundColor = UIColor(named: "Yellow")
        return button
    }()
    
    func configure() {
        contentView.addSubview(allServiceButton)
        
        NSLayoutConstraint.activate([
            allServiceButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            allServiceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            allServiceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            allServiceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
