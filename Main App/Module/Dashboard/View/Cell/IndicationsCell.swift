import UIKit

final class IndicationsCell: UITableViewCell {
    
    static let stringID = "IndicationsCell"
    
    private let backImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 17.5
        view.backgroundColor = UIColor(named: "Blue")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let iconView: UIImageView = {
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
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let indicationImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(item: MenuItem) {
        
        selectionStyle = .none
        
        contentView.addSubview(backImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        backImageView.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            backImageView.heightAnchor.constraint(equalToConstant: 35),
            backImageView.widthAnchor.constraint(equalToConstant: 35),
            backImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            
            iconView.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: backImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: 10),
            
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor)
        ])
        
        titleLabel.text = item.name
        subLabel.text = item.description
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small)
        
        if item.expected != nil {
            let indicatorSpacing: CGFloat = 2
            
            var currentX: CGFloat = 18
            
            for indicator in item.expected!.indications {
                
                contentView.addSubview(indicationImageView)

                NSLayoutConstraint.activate([
                    indicationImageView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
                    indicationImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                    indicationImageView.widthAnchor.constraint(equalToConstant: 10),
                ])

                currentX += indicationImageView.frame.width + indicatorSpacing
                
                switch indicator.type {
                case "water":
                    indicationImageView.image = UIImage(systemName: "drop.fill")
                case "electricity":
                    indicationImageView.image = UIImage(systemName: "lightbulb.fill")
                default:
                    indicationImageView.image = UIImage(systemName: "exclamationmark.circle.fill")
                }
                
            }
            
        } else {
            
            guard let price = item.arrear else { return }
            
            contentView.addSubview(priceLabel)
            
            NSLayoutConstraint.activate([
                priceLabel.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
                priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
            ])
            
            let formattedSum = price.replacingOccurrences(of: ".", with: ",")

            let fullSumString = formattedSum + " ₽"

            let attributedString = NSMutableAttributedString(string: fullSumString)

            if let commaRange = fullSumString.range(of: ",") {
                let startIndex = fullSumString.distance(from: fullSumString.startIndex, to: commaRange.upperBound)
                let endIndex = startIndex + 2
                
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSRange(location: startIndex, length: endIndex - startIndex))
                priceLabel.attributedText = attributedString
            }
            
            
        }
        
        if item.action == "payment" {
            iconView.image = UIImage(systemName: "rublesign.circle", withConfiguration: imageConfig)
        } else if item.action == "meters" {
            iconView.image = UIImage(systemName: "barometer", withConfiguration: imageConfig)
        }
        
    }
    
}
