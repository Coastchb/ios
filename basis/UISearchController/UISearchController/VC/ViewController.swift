//
//  ViewController.swift
//  UISearchController
//
//  Created by coastcao(操海兵) on 2019/10/28.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    var recommends = ["Java", "Swift"]
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.recommend_history_view.dequeueReusableCell(withIdentifier: "UITableViewCellReuseIdentifier", for: indexPath)
        cell.textLabel?.text = recommends[indexPath.row]
        return cell
    }*/
    

    @IBOutlet weak var main_view: UITableView!
    
    /// State restoration values.
    private enum RestorationKeys: String {
        case viewControllerTitle
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
    }
    
    /// NSPredicate expression keys.
    private enum ExpressionKeys: String {
        case title
        case yearIntroduced
        case introPrice
    }
    
    private struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }
    
    /// Restoration state for UISearchController
     private var restoredState = SearchControllerRestorableState()
    
    private var searchController : UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.recommend_history_view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellReuseIdentifier")
        self.main_view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellReuseIdentifier")
        
        // Do any additional setup after loading the view.
        var searchResultController = SearchResultVC()
        searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
        
        /*
        self.recommend_history_view.alpha = 0
        self.recommend_history_view.isHidden = true
        
        self.recommend_history_view.delegate = self
        self.recommend_history_view.dataSource = self
        */
        
        let main_vc = MainTableViewController()
        self.main_view.delegate = main_vc
        self.main_view.dataSource = main_vc
        
        //self.view.addSubview(recommend_history_view)
        //self.view.addSubview(main_view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive {
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.resignFirstResponder()
    }
    
}


extension ViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
        

    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
        
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
        //var canVC = candidateTableVC()
        //present(canVC, animated: true)
        //self.view.backgroundColor = UIColor.yellow

        self.main_view.alpha = 0
        self.main_view.isHidden = true
        
        /*
        self.recommend_history_view.alpha = 1
        self.recommend_history_view.isHidden = false
        self.recommend_history_view.resignFirstResponder()
        self.recommend_history_view.scrollsToTop = true
 */

    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
       /*
        self.recommend_history_view.alpha = 0
        self.recommend_history_view.isHidden = true
 */
        self.main_view.alpha = 1
        self.main_view.isHidden = false
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")

        

    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("search text: \(searchController.searchBar.text)")
    }
    
}
