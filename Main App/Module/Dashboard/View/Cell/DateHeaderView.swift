import UIKit

final class DateHeaderView: UITableViewHeaderFooterView {
    
    static let stringID = "DateHeaderView"
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(date: String) {
        
         addSubview(todayLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            todayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            todayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            
            dateLabel.bottomAnchor.constraint(equalTo: todayLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: todayLabel.trailingAnchor, constant: 5)
        ])
        
        dateLabel.text = removeLeadingZero(from: date)
    }
    
    private func removeLeadingZero(from date: String) -> String {
        if date.hasPrefix("0") {
            return String(date.dropFirst())
        }
        return date
    }
    
}
