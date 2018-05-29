//
//  FeedsDataSource.swift
//  iOSProgressiveExercise
//
//  Created by Nischal Hada on 5/29/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    fileprivate let landscapeReuseIdentifier = "LandscapeTableViewCell"
}

class FeedsDataSource : GenericDataSource<ListModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: landscapeReuseIdentifier, for: indexPath) as! LandscapeTableViewCell
        let feedsValue = self.data.value[indexPath.row]
        cell.feedsValue = feedsValue
        if feedsValue.imageRef != ""  && feedsValue.imageRef != "N/A"{
            ImageHelper().updateImageForTableViewCell(cell, inTableView: tableView, imageURL:feedsValue.imageRef, atIndexPath: indexPath){ (success, image) -> Void in
                if success && image != nil {
                    cell.thumbnailImage.isHidden = false
                    cell.imageWidthConstraint.constant = 60
                }else{
                    cell.thumbnailImage.isHidden = true
                    cell.imageWidthConstraint.constant = 0
                }
            }
        }else{
            cell.thumbnailImage.isHidden = true
            cell.imageWidthConstraint.constant = 0
        }
        return cell
    }
}
