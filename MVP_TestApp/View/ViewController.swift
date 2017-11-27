//
//  ViewController.swift
//  MVP_TestApp
//
//  Created by Pranil on 11/24/17.
//  Copyright © 2017 pranil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = ItemPresenter(itemService: ItemService())
    var itemToDisplay = [ItemViewDataModel]()
    var tempItemToDisplay = [ItemViewDataModel]()
    var refreshControll          = UIRefreshControl()
    var objects = Array<Any>()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self as? UITableViewDataSource
        presenter.attachView(view: self as ItemViewModel)
        presenter.getItems()
        
        self.tableView.refreshControl = refreshControll
        self.refreshControll.addTarget(self, action: #selector(self.initPullRefresh(_:)), for: .valueChanged)
        
       
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func initPullRefresh(_ refresh: UIRefreshControl) {
        let delayTime = DispatchTime.now()+2
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.itemToDisplay = self.tempItemToDisplay
            self.count = self.itemToDisplay.count
            
            self.tableView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2;
        formatter.locale = Locale(identifier: "id_ID")
        var result = formatter.string(from: value as NSNumber);
        result = result?.replacingOccurrences(of: "Rp", with: "Rs. ")
        return result!
    }
    
    func deleteData(index: Int) {
        
        self.tableView.beginUpdates()
        itemToDisplay.remove(at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        
        self.tableView.endUpdates()
    }
    
}

extension ViewController: ItemViewModel{
    func startLoading() {
        // show hud
    }
    
    func finishLoading() {
        // stop hud
    }
    
    func setItems(items: [ItemViewDataModel]) {
        itemToDisplay = items
        tempItemToDisplay = items
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmptyItems() {
        self.tableView.isHidden = true
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let cartViewData = itemToDisplay[indexPath.row]
        
        cell.textLabel?.text = cartViewData.namaBarang
        cell.detailTextLabel?.text = self.formatCurrency(value: cartViewData.hargaBarang)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.deleteData(index: indexPath.row)
        }
        
    }
}

