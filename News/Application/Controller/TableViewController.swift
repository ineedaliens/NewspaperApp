//
//  TableViewController.swift
//  News
//
//  Created by Евгений on 07.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var newsdata: Array<Dictionary<String, Any>>?
    var networkService = NetworkService()
    var imageData: Array<Dictionary<String, Any>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil ,action: nil)
        networkService.fetchData()
        networkService.newsDataHandler = { news in
            self.newsdata = news
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            return nil
        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = newsdata else { return 0 }
        return news.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete", handler: { _,_,_  in
            self.newsdata?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        delete.backgroundColor = .red
        return swipe
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "web" {
            guard let news = newsdata else { return }
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let row = news[indexPath.row] as? Dictionary<String, Any> else { return }
                guard let url = row["url"] as? String else { return }
                guard let title = row["title"] as? String else { return }
                let dvc = segue.destination as! WebVC
                dvc.urlPage = url
                dvc.head = title
            }
        }
    }
}
