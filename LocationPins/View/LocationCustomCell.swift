//
//  LocationCustomCell.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation
import UIKit

class LocationCustomCell: UITableViewCell {
  
  let cellView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.layer.cornerRadius = 10
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let locationDescription: UILabel = {
    let label = UILabel()
    label.text = "label"
    label.numberOfLines = 2
    label.adjustsFontSizeToFitWidth = true
    label.lineBreakMode = NSLineBreakMode.byClipping
    label.textColor = UIColor.black
    label.font = UIFont.systemFont(ofSize: 15.0)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let subtitle: UILabel = {
    let label = UILabel()
    label.text = "lat/lon"
    label.textColor = UIColor.black
    label.font = UIFont.systemFont(ofSize: 12.0)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    
    cellView.addSubview(locationDescription)
    cellView.addSubview(subtitle)
    
    self.addSubview(cellView)
    self.selectionStyle = .none
    
    NSLayoutConstraint.activate([
      cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
      cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
      cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
    
    locationDescription.widthAnchor.constraint(equalToConstant: cellView.frame.width).isActive = true
    locationDescription.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
    locationDescription.bottomAnchor.constraint(equalTo: subtitle.topAnchor,constant: -10).isActive = true
    locationDescription.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 5).isActive = true
    locationDescription.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: 5).isActive = true

    subtitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    subtitle.widthAnchor.constraint(equalToConstant: cellView.frame.width).isActive = true
    subtitle.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
    subtitle.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 5).isActive = true
    subtitle.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: 5).isActive = true
  }

  
}
