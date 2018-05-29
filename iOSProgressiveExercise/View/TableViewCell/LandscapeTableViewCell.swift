//
//  LandscapeTableViewCell.swift
//  iOSProgressiveExercise
//
//  Created by Nischal Hada on 5/29/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class LandscapeTableViewCell: UITableViewCell {
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    var feedsValue : ListModel? {
        didSet {
            guard let feeds = feedsValue else {
                return
            }
            titleLabel?.text = feeds.title
            descriptionLabel?.text = feeds.description
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImage.contentMode =   UIViewContentMode.scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
