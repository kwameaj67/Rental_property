//
//  FilterVC+Delegates.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/9/23.
//

import UIKit


enum row: Int {
    case price_section = 0
    case convenience_section = 1
    case guests = 2
}
extension FilterVC: FilterHeaderViewDelegate {
    func dismissVC() {
        print("DEBUG: dismiss FilterVC")
        dismiss(animated: true)
    }
    
    func resetFilters() {
        print("DEBUG: reset filters")
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource -
extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == row.price_section.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.reusableID, for: indexPath) as? PriceTableViewCell else {
                fatalError("Cannot dequeue price cell")
            }
            return cell
        }
        else if indexPath.row == row.convenience_section.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConvenienceTableViewCell.reusableID, for: indexPath) as? ConvenienceTableViewCell else {
                fatalError("Cannot dequeue price cell")
            }
            return cell
        }
        else if indexPath.row == row.guests.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.reusableID, for: indexPath) as? GuestTableViewCell else {
                fatalError("Cannot dequeue price cell")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == row.price_section.rawValue {
            return CGFloat(200)
        }
        else if indexPath.row == row.convenience_section.rawValue {
            return CGFloat(300)
        }
        else if indexPath.row == row.guests.rawValue {
            return CGFloat(150)
        }
        return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = FilterFooterView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(100)
    }
}
