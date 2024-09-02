import UIKit

final class ButtonCell: UITableViewCell {
    
    static let stringID = "ButtonCell"
    
    private lazy var allServiceButton: CustomButton = {
        let button = CustomButton(title: "Все сервисы")
        button.backgroundColor = UIColor(named: "Yellow")
        return button
    }()
    
    func configure() {
        
        selectionStyle = .none
        
        contentView.addSubview(allServiceButton)
        
        NSLayoutConstraint.activate([
            allServiceButton.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            allServiceButton.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: 5),
            allServiceButton.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor, constant: -5),
            allServiceButton.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)
        ])

    }
    
}
