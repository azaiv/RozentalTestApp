import UIKit

final class DashboardViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<DashboardSection, DashboardItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<DashboardSection, DashboardItem>
    
    private var dataSource: DataSource!
    private var snapshot: Snapshot!
    private var viewModel: DashboardViewModelProtocol!
    private var customNavBar: CustomNavigation!
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemBackground
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.stringID)
        tableView.register(IndicationsCell.self, forCellReuseIdentifier: IndicationsCell.stringID)
        tableView.register(BannersCell.self, forCellReuseIdentifier: BannersCell.stringID)
        tableView.register(ServicesCell.self, forCellReuseIdentifier: ServicesCell.stringID)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.stringID)
        tableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: DateHeaderView.stringID)
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    init(viewModel: DashboardViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityIndicator()
        
        self.setupView()
        self.configureDataSource()
        self.applySnapshot(sections: self.setupData(data: self.viewModel.data!))
        self.activityIndicator.removeFromSuperview()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let profile = viewModel.data?.myProfile else { return }
        
        self.setupNavigation(profile: profile)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.layer.cornerRadius = 20
        tableView.layer.cornerCurve = .continuous
        
        view.backgroundColor = UIColor(named: "Blue")
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Главная"
    }
    
    private func setupNavigation(profile: MyProfile) {
        
        customNavBar = CustomNavigation(
            name: profile.shortName,
            address: profile.address,
            url: profile.photo)
        
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
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            switch item {
            case .message(let count):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.stringID, for: indexPath) as? MessageCell else {
                    return UITableViewCell()
                }
                cell.configure(count: count)
                return cell
            case .indications(_, let item):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IndicationsCell.stringID, for: indexPath) as? IndicationsCell else {
                    return UITableViewCell()
                }
                cell.configure(item: item)
                return cell
            case .banners(let banners):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BannersCell.stringID) as? BannersCell else {
                    return UITableViewCell()
                }
                cell.configure(banners: banners)
                return cell
            case .services(let service):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.stringID) as? ServicesCell else { return UITableViewCell() }
                cell.configure(banners: service)
                return cell
            case .button(_):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.stringID) as? ButtonCell else {
                    return UITableViewCell()
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
    }
    
    private func setupData(data: MainData) -> [DashboardSection] {
        
        var menuItems: [DashboardItem] = []
        
        data.customerDashboard.menuItems.forEach({ item in
            menuItems.append(.indications(id: UUID(), menu: item))
        })
        
        
        let sections: [DashboardSection] = [
            .init(type: .messange,
                  item: [.message(count: viewModel.data?.myNewNotifications ?? 0)]),
            .init(
                type: .indications,
                item: menuItems),
            .init(type: .banners,
                  item: [.banners(banner: data.customerDashboard.banners)]),
            .init(type: .services,
                  item: [.services(service: data.customerDashboard.services)]),
            .init(
                type: .button,
                item: [.button(id: UUID())])
        ]
        
        return sections
        
    }
    
}

extension DashboardViewController: UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let section = dataSource.sectionIdentifier(for: section)?.type
        
        switch section {
        case .messange:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeaderView.stringID) as? DateHeaderView else { return nil }
            header.configure(date: viewModel.data?.customerDashboard.date ?? "")
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource.sectionIdentifier(for: section)?.type
        
        switch section {
        case .messange:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = dataSource.sectionIdentifier(for: indexPath.section)?.type
        
        switch section {
        case .services:
            return 100
        case .banners, .button:
            return 70
        default:
            return 60
        }
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        barAppearance.backgroundColor = .clear
        barAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        barAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ]
        navigationItem.standardAppearance = barAppearance
    }
    
}

