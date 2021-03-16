//
//  TableViewController.swift
//  News
//
//  Created by Евгений on 07.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var newsdata: News?
    private let url = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(apiKey)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil ,action: nil)
        NetworkService.fetchData(url: url) { (newsdata) in
            self.newsdata = newsdata
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = newsdata?.results.count else {return 0}
        return news
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let newsdatas = newsdata?.results[indexPath.row]
        
        let urlImage = newsdata?.results[indexPath.row].multimedia[indexPath.section].url
        
        cell.titleLabel.text = newsdatas?.title
        cell.abstractLabel.text = newsdatas?.abstract
        cell.sectionLabel.text = newsdatas?.section
        NetworkService.downloadImage(url: urlImage!, indexPath: indexPath) { (image) in
            DispatchQueue.main.async {
                cell.imageViews.image = image
            }
        }
        
        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete", handler: { _,_,_  in
//            self.newsdata?.results.remove(at: indexPath.row)
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
                let dvc = segue.destination as! WebVC
                dvc.urlPage = news.results[indexPath.row].url!
                dvc.head = news.results[indexPath.row].title
            }
        }
    }
}
