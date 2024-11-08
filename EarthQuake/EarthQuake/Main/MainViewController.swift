//
//  MainViewController.swift
//  EarthQuake
//
//  Created by Layne on 2024/11/7.
//

import UIKit
import Combine
import MBProgressHUD

class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let view = UITableView.init(frame: .zero)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(EarthQuakeItemCell.self, forCellReuseIdentifier: EarthQuakeItemCell.description())
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "EarthQuake"
        
        setupViews()
        setupObserver()
        loadData()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupObserver() {
        viewModel.$status.sink { [weak self] status in
            guard let self = self, let status = status else { return }
            switch status {
            case .loading:
                MBProgressHUD.showAdded(to: self.view, animated: true)
            case .success:
                MBProgressHUD.hide(for: self.view, animated: true)
                self.tableView.reloadData()
            case .failure:
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }.store(in: &subscriptions)
    }
    
    private func loadData() {
        viewModel.loadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

// MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let earthquake = viewModel.data?[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: EarthQuakeItemCell.description(), for: indexPath) as? EarthQuakeItemCell
        else {
            return UITableViewCell()
        }

        cell.config(earthquake)
        return cell
    }

// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let urlString = viewModel.data?[indexPath.row]?.properties.url,
              // Map information indicating the location of the earthquake is already provided by USGS
              // We use it directly.
              let url = URL(string: urlString + "/map")
        else { return }
        let mapViewController = MapViewController(url: url)
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
