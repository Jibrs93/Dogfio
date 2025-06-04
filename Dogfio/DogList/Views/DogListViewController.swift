//
//  DogListViewController.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 02/06/25.
//

import UIKit

final class DogListViewController: UIViewController {
    private let viewModel = DogListViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dogs We Love"
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .textPrimary
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search dog by name"
        sb.searchBarStyle = .minimal
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No dogs found 🐾"
        label.textAlignment = .center
        label.textColor = .textSecondary
        label.font = .systemFont(ofSize: 16)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .appBackground
        setupUI()
        bindViewModel()
        viewModel.loadDogs()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        tableView.register(DogTableViewCell.self, forCellReuseIdentifier: "DogCell")
        refreshControl.addTarget(self, action: #selector(refreshDogs), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onDataChanged = { [weak self] in
            guard let self = self else { return }
            self.emptyStateLabel.isHidden = self.viewModel.count > 0
            self.tableView.reloadData()
        }
    }
    
    @objc private func refreshDogs() {
        viewModel.loadDogs()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
            UserDefaults.standard.set(false, forKey: "hasLoadedDogs")
        }
    }
}

// MARK: TableView
extension DogListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as? DogTableViewCell else {
            return UITableViewCell()
        }
        
        let dog = viewModel.dog(index: indexPath.row)
        cell.configure(dog: dog)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dog = viewModel.dog(index: indexPath.row)
        let detailVC = DogDetailViewController(dog: dog)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(detailVC, animated: true)
        navigationController?.navigationBar.tintColor = .textPrimary

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: SearchBar
extension DogListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterDogs(query: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
