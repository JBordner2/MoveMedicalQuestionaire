//
//  LandingPageViewController.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import UIKit

class ItemsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [Item] = [Car(name: "Jacks Honda", description: "Built in Japan", model: "Accord", year: 2008), Phone(name: "Jack Bordner", description: "Potential Co-Worker", number: 2068540400, business: nil), Book(name: "The Power of Your Subconscious Mind", description: "Whether the object of your faith is real or false, you will get results. Your subconscious mind responds to the thought in your mind. Look upon faith as a thought in your mind and it will suffice.", numberOfPages: 293, author: "Joseph Murphy")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "LandingPageTableViewCell", bundle: nil), forCellReuseIdentifier: "landingPageTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavBar() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonAction(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func rightBarButtonAction(sender : UIBarButtonItem) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "itemFormViewController") as! ItemFormViewController
        viewController.delegate = self

        self.present(viewController, animated: true, completion: nil)
    }
    
    private func presentItemDetailViewController(forItem item: Item) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "itemDetailViewController") as! ItemDetailViewController
        viewController.item = item

        self.present(viewController, animated: true, completion: nil)
    }
}

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "landingPageTableViewCell", for: indexPath) as? LandingPageTableViewCell else { return  UITableViewCell() }
        
        let item = data[indexPath.row]
        cell.configure(withItem: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = data[indexPath.row]
        presentItemDetailViewController(forItem: selectedItem)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ItemsViewController: ItemFormViewControllerDelegate {
    func didCreateNewItem(item: Item) {
        data.insert(item, at: 0)
        tableView.reloadData()
    }
}
