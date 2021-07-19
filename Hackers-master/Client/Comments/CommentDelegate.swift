//
//  CommentDelegate.swift
//  Hackers2
//
//  Created by Weiran Zhang on 01/09/2014.
//  Copyright (c) 2014 Glass Umbrella. All rights reserved.
//

import UIKit

protocol CommentDelegate: class {
    func commentTapped(_ sender: UITableViewCell)
    func linkTapped(_ url: URL, sender: UITextView)
}
