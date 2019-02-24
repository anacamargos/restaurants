//
//  RestaurantTableViewController.swift
//  Restaurants
//
//  Created by Ana Leticia Camargos on 23/02/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit

protocol ListActions: class {
    func didTapCell(_ viewController:UIViewController,_ viewModel: RestaurantListViewModel)
}

class RestaurantTableViewController: UITableViewController {
    
    var viewModels = [RestaurantListViewModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    weak var delegate: ListActions?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

    }

    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell

        let vm = viewModels[indexPath.row]
        cell.configure(with: vm)
        

        return cell
    }
    
    //MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsFoodViewController") else { return }
        navigationController?.pushViewController(detailsViewController, animated: true)
        let vm = viewModels[indexPath.row]
        delegate?.didTapCell( detailsViewController, vm)
    }
    
}
