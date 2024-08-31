import UIKit

final class DashboardViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<DashboardSection, DashboardItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<DashboardSection, DashboardItem>
    
    private var dataSource: DataSource!
    private var snapshot: Snapshot!
    
    private var viewModel: DashboardViewModel!
    
    private var customNavBar: CustomNavigation!
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collectionView.register(IndicationsCell.self, forCellWithReuseIdentifier: IndicationsCell.stringID)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.stringID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DashboardViewModel()
        
        setupActivityIndicator()
        
        viewModel.getData(completion: { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.setupView()
                    self.configureDataSource()
                    self.applySnapshot(sections: self.setupData(data: self.viewModel.data!))
                    self.activityIndicator.removeFromSuperview()
                }
            }
        })
    
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let profile = viewModel.data?.myProfile else { return }

        self.setupNavigation(profile: profile)
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = .black
        activityIndicator.backgroundColor = .systemBackground
        activityIndicator.startAnimating()
    }
    
    private func setupView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        collectionView.layer.cornerRadius = 20
        collectionView.layer.cornerCurve = .continuous
        collectionView.backgroundColor = .systemBackground
        
        view.backgroundColor = UIColor(named: "Blue")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigation(profile: MyProfile) {
        
        customNavBar = CustomNavigation(
            name: profile.shortName,
            address: profile.address)
        
        let navBar = navigationController!.navigationBar
        
        if navBar.subviews.contains(customNavBar) == false {
            navBar.backgroundColor = UIColor(named: "Blue")
            
            for subview in navBar.subviews {
                if let _ = subview.subviews.first(where: { $0 is UILabel }) {
                    
                    subview.addSubview(customNavBar)
                    customNavBar.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        customNavBar.topAnchor.constraint(equalTo: navBar.topAnchor),
                        customNavBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor),
                        customNavBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor),
                        customNavBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor),
                    ])
                }
            }
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(50))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 20, leading: 20, bottom: 5, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .messange:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                return cell
            case .indications(_, let image, let title, let sub):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicationsCell.stringID, for: indexPath) as? IndicationsCell else {
                    return UICollectionViewCell()
                }
                cell.configure(image: image, title: title, sub: sub)
                return cell
            case .ads:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                return cell
            case .horizontal:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                return cell
            case .button(_):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.stringID, for: indexPath) as? ButtonCell else {
                    return UICollectionViewCell()
                }
                cell.configure()
                return cell
            }
        })
    }
    
    private func applySnapshot(sections: [DashboardSection]) {
        snapshot = Snapshot()

        for item in sections {
            snapshot.appendSections([item])
            snapshot.appendItems(item.item, toSection: item)
        }
        
        dataSource.apply(snapshot)
        self.view.layoutIfNeeded()
    }
    
    private func setupData(data: MainData) -> [DashboardSection] {
        
        var menuItems: [DashboardItem] = []
        
        data.customerDashboard.menuItems.forEach({ item in
            menuItems.append(.indications(
                id: UUID(),
                image: "",
                title: item.name,
                sub: item.description))
        })
        
        
        let sections: [DashboardSection] = [
            .init(
                type: .indications,
                item: menuItems),
            .init(
                type: .button,
                item: [.button(id: UUID())])
        ]
        
        return sections
        
    }
    
}

extension DashboardViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        barAppearance.backgroundColor = .clear
        
        navigationItem.standardAppearance = barAppearance
    }
    
}
