//
//  MainViewController.swift
//  EarthQuake
//
//  Created by Layne on 2024/11/7.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let view = UITableView.init(frame: .zero)
        view.backgroundColor = .white
//        view.delegate = self
//        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
            guard let self = self else { return }
            
        }.store(in: &subscriptions)
    }
    
    private func loadData() {
        viewModel.loadData()
    }
}

//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//
//}
