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
    var details: String
    var isDone: Bool
    init(title: String, deadline: Date, details: String, isDone: Bool) {
        self.title = title
        self.deadline = deadline
        self.details = details
        self.isDone = isDone
    }
}
