import UIKit

final class IndicationsCell: UICollectionViewCell {
    
    static let stringID = "IndicationsCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 17.5
        imageView.backgroundColor = UIColor(named: "Blue")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(image: String, title: String, sub: String) {
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 35),
            imageView.widthAnchor.constraint(equalToConstant: 35),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            
            subLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        titleLabel.text = title
        subLabel.text = sub
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 5, weight: .regular, scale: .default)
        
//        imageView.image = UIImage(systemName: image, withConfiguration: imageConfig)
        
    }
    
}
