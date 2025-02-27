//
//  HNLogger.swift
//  HintsAndNotes
//
//  Created by Dylan  on 2/25/25.
//

import OSLog

struct HNLogger {
    enum Category: String {
        case captureSession
        case imagePicker
        case permissions
    }

    let subsystem = "com.hintsandnotes."
    let category: Category
    var logger: Logger {
        Logger(subsystem: subsystem, category: category.rawValue)
    }
}

enum HNLog {
    static func debug(category: HNLogger.Category, message: String) {
        let logger = HNLogger(category: category).logger
        logger.log(level: .debug, "\(message)")
    }
}
