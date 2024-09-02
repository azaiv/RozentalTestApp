import UIKit

final class ServicesCell: UITableViewCell {
    
    static let stringID = "ServicesCell"
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    func configure(banners: [Service]) {
        
        selectionStyle = .none
        
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let screenWidth = contentView.frame.width
        let bannerWidth = screenWidth / 3
        let bannerSpacing: CGFloat = 10
        
        var currentX: CGFloat = 18
        
        for banner in banners {
            let bannerView = createBannerView(service: banner)
            scrollView.addSubview(bannerView)
            
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                bannerView.topAnchor.constraint(equalTo: scrollView.readableContentGuide.topAnchor),
                bannerView.bottomAnchor.constraint(equalTo: scrollView.readableContentGuide.bottomAnchor),
                bannerView.widthAnchor.constraint(equalToConstant: bannerWidth),
                bannerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: currentX)
            ])
            
            currentX += bannerWidth + bannerSpacing
        }
        
        
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 18)
        
        scrollView.contentSize = CGSize(width: currentX - bannerSpacing,
                                        height: contentView.frame.height)
        
    }
    
    private func createBannerView(service: Service) -> UIView {
        
        let bannerView = UIView()
        bannerView.backgroundColor = .systemGray6.withAlphaComponent(0.6)
        bannerView.layer.cornerCurve = .continuous
        bannerView.layer.cornerRadius = 12
        
        let backImageView = UIView()
        backImageView.layer.cornerRadius = 17.5
        backImageView.backgroundColor = UIColor(named: "Blue")
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        bannerView.addSubview(backImageView)
        bannerView.addSubview(titleLabel)
        backImageView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 12),
            backImageView.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            backImageView.heightAnchor.constraint(equalToConstant: 35),
            backImageView.widthAnchor.constraint(equalToConstant: 35),
            
            imageView.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -10)
        ])
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .default)
        
        switch service.action {
        case "intecom":
            imageView.image = UIImage(systemName: "person.crop.square.badge.video", withConfiguration: imageConfig)
        case "video":
            imageView.image = UIImage(systemName: "video", withConfiguration: imageConfig)
        case "docs":
            imageView.image = UIImage(systemName: "doc", withConfiguration: imageConfig)
        case "offer":
            imageView.image = UIImage(systemName: "message", withConfiguration: imageConfig)
        case "poll":
            imageView.image = UIImage(systemName: "list.bullet", withConfiguration: imageConfig)
        case "basip":
            imageView.image = UIImage(systemName: "lock.shield", withConfiguration: imageConfig)
        case "vote":
            imageView.image = UIImage(systemName: "checkmark.seal", withConfiguration: imageConfig)
        case "pass":
            imageView.image = UIImage(systemName: "wallet.pass", withConfiguration: imageConfig)
        default:
            imageView.image = UIImage(systemName: "square", withConfiguration: imageConfig)
        }
        
        titleLabel.text = service.name
        
        return bannerView
    }

}

