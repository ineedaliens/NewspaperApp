//
//  Extensions.swift
//  News
//
//  Created by Евгений on 07.03.2021.
//

import UIKit

extension TableViewController {
    func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
       let indexPath = indexPath.row
       

       guard let news = newsdata else { return }
       guard let rows = news[indexPath] as? Dictionary<String, Any> else {return}
       guard let title = rows["title"] as? String else { return }
       guard let abstract = rows["abstract"] as? String else { return }
       guard let section = rows["section"] as? String else { return }
        
       DispatchQueue.main.async {
           cell.titleLabel.text = title
           cell.abstractLabel.text = abstract
           cell.sectionLabel.text = section
       }
   }
}
