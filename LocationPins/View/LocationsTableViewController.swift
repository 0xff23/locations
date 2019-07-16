//
//  LocationsTableViewController.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation
import UIKit

class LocationsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var viewModel = UserLocationsViewModel(with: "")

  let tableview: UITableView = {
    let tableview = UITableView()
    tableview.backgroundColor = UIColor.white
    tableview.translatesAutoresizingMaskIntoConstraints = false
    tableview.separatorColor = UIColor.white
    return tableview
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableview.delegate = self
    tableview.dataSource = self
    
    setupTableView()
  }
  
  func setupTableView() {
    tableview.register(LocationCustomCell.self, forCellReuseIdentifier: "cellId")
    
    view.addSubview(tableview)
    
    NSLayoutConstraint.activate([
      tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
      tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
      ])
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.userLocations().count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! LocationCustomCell
    
    cell.locationDescription.text = viewModel.userLocations()[indexPath.row].desc
    cell.subtitle.text = "Lat: \(viewModel.userLocations()[indexPath.row].latitude) | Lon: \(viewModel.userLocations()[indexPath.row].longitude)"
    cell.backgroundColor = UIColor.white
    return cell
  }
  
}
