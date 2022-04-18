//
//  ViewController.swift
//  TestProjectRickMorty
//
//  Created by MAC on 18.04.2022.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Property
    
    private lazy var  searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search name..."
        definesPresentationContext = true
        return searchController
    }()
    
    private var filteredChar = [Character]()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    var characters = [Character]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifire)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 90
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
        fetchData()
    }
    
    // MARK: - Request
    
    func fetchData() {
        if let url = URL(string: "https://rickandmortyapi.com/api/character") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = response as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let data = data {
                        print(data)
                        print(resp)
                        
                        do {
                            let char = try JSONDecoder().decode(Characters.self, from: data)
                            self.characters.append(contentsOf: char.results)
                            print(char)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Hierarchy
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

// MARK: - Extension UITableViewDelegate, UITableViewDataSource

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredChar.count
        }
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifire, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.character = characters[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let char = self.characters[indexPath.row]
        let vc = ViewControllerDetail()
        vc.character = char
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension UISearchResultsUpdating, UIScrollViewDelegate

extension TableViewController: UISearchResultsUpdating, UIScrollViewDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filteredChar = characters.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            fetchData()
        }
    }
}
