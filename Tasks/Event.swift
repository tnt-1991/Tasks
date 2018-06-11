//
//  Event.swift
//  Tasks
//
//  Created by Kirill Klimovich on 09/06/2018.
//  Copyright © 2018 Kirill Klimovich. All rights reserved.
//

import Foundation

class Event{
    var title: String
    var deadline: Date
    init(title: String, deadline: Date) {
        self.title = title
        self.deadline = deadline
    }
}
