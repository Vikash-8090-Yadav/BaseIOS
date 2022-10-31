//
//  FinderFunctions.swift
//  BaseFinderiOS
//
//  Created by Antoine Bollengier on 31.10.22.
//

import Foundation

let fc = FileManager.default

func getFilesInDirectory(path: String) throws -> [String] {
    do {
        let content = try fc.contentsOfDirectory(atPath: path)
        return content
    } catch {
        print(error)
    }
    let crashString: String? = nil
    crashString!
}
