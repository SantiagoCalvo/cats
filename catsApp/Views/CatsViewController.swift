//
//  CatsViewController.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import UIKit

class CatsViewController: UITableViewController {
    
    let catsPresenter: CatsPresenterProtocol
    
    var cats: [Cat] = []
    
    init(catsPresenter: CatsPresenterProtocol) {
        self.catsPresenter = catsPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(CatCell.self, forCellReuseIdentifier: CatCell.identifier)
        
        catsPresenter.getCats()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cats[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCell.identifier, for: indexPath) as! CatCell
        
        cell.configure(with: cellModel)
        return cell
    }
    
}

extension CatsViewController: CatsViewDelegate {
    func showCats(cats: [Cat]) {
        self.cats = cats
        tableView.reloadData()
    }
    
    func showErrorMessage(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self] _ in
            guard let self = self else {return}
            self.catsPresenter.getCats()
        }))
        present(alert, animated: false)
    }
}
