import UIKit

final class BannersCell: UITableViewCell {
    
    static let stringID = "BannersCell"
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    func configure(banners: [Banner]) {
        
        selectionStyle = .none
        
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let screenWidth = frame.width
        let bannerWidth = screenWidth * 0.8
        let bannerSpacing: CGFloat = 10
        
        var currentX: CGFloat = 18
        
        for banner in banners  {
            let bannerView = createBannerView(banner: banner)
            scrollView.addSubview(bannerView)
            
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                bannerView.topAnchor.constraint(equalTo: scrollView.readableContentGuide.topAnchor),
                bannerView.bottomAnchor.constraint(equalTo: scrollView.readableContentGuide.bottomAnchor),
                bannerView.widthAnchor.constraint(equalToConstant: bannerWidth),
                bannerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: currentX)
            ])
            
            bannerView.layer.shadowColor = UIColor.black.cgColor
            bannerView.layer.shadowOpacity = 0.1
            bannerView.layer.shadowOffset = CGSize(width: 0, height: 1)
            bannerView.layer.shadowRadius = 4
            bannerView.layer.masksToBounds = false

            currentX += bannerWidth + bannerSpacing
        }
        
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 18)

        scrollView.contentSize = CGSize(width: currentX - bannerSpacing,
                                        height: contentView.frame.height)
        
    }
    
    private func createBannerView(banner: Banner) -> UIView {
        let bannerView = UIView()
        bannerView.backgroundColor = .systemBackground
        bannerView.layer.borderColor = UIColor.systemGray5.cgColor
        bannerView.layer.borderWidth = 0.5
        bannerView.layer.cornerCurve = .continuous
        bannerView.layer.cornerRadius = 12
        
 
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.minimumScaleFactor = 0.6
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subLabel = UILabel()
        subLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subLabel.textColor = .systemGray
        subLabel.minimumScaleFactor = 0.3
        subLabel.adjustsFontSizeToFitWidth = true
        subLabel.numberOfLines = 2
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bannerView.addSubview(imageView)
        bannerView.addSubview(titleLabel)
        bannerView.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 35),
            imageView.widthAnchor.constraint(equalToConstant: 35),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -10),
            
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subLabel.bottomAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor)
        ])
        
        titleLabel.text = banner.title
        subLabel.text = banner.text
        self.loadImage(from: banner.image,
                       into: imageView)
        
        return bannerView
    }
    
    private func loadImage(from url: String, into imageView: UIImageView) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        
        task.resume()
    }
    
}
