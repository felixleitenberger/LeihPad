//
//  User.swift
//  RuppPadOnboarding
//
//  Created by Felix Leitenberger on 23.10.23.
//

import Foundation
import SwiftData

@Model 
class User {
    var id: UUID
    var time: Date

    var firstName: String
    var lastName: String
    var room: String
    var course: String
    var teacher: String
    
    var checkedIpad: Bool
    var reportedSomethingToTeacher: Bool
    var finishedOnbarding: Bool

    init(firstName: String = "", lastName: String = "", room: String = "", course: String = "", teacher: String = "", checkedIpad: Bool = false, reportedSomethingToTeacher: Bool = false, finishedOnbarding: Bool = false) {
        self.id = UUID()
        self.time = Date.now
        self.firstName = firstName
        self.lastName = lastName
        self.room = room
        self.course = course
        self.teacher = teacher
        self.checkedIpad = checkedIpad
        self.reportedSomethingToTeacher = reportedSomethingToTeacher
        self.finishedOnbarding = finishedOnbarding
    }
}
