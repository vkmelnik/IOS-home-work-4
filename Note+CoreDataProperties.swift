//
//  Note+CoreDataProperties.swift
//  vkmelnikPW4
//
//  Created by Vsevolod Melnik on 23.10.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var creationDate: Date
    @NSManaged public var status: Int32
    @NSManaged public var linkToNote: Note?

}

extension Note : Identifiable {

}
