//
//  FileManager-DocumentsDirectory.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import Foundation
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
