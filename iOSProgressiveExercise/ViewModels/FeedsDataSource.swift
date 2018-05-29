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
        let feedsValue = self.data.value[indexPath.row]
        if feedsValue.imageRef != ""  && feedsValue.imageRef != "N/A"{
            let cell = tableView.dequeueReusableCell(withIdentifier: landscapeReuseIdentifier, for: indexPath) as! LandscapeTableViewCell
            cell.feedsValue = feedsValue
            ImageHelper().updateImageForTableViewCell(cell, inTableView: tableView, imageURL:feedsValue.imageRef, atIndexPath: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header")!
            cell.textLabel?.text = feedsValue.title
            cell.detailTextLabel?.text = feedsValue.description
            return cell
        }
    }
}

