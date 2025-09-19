//
//  AppLogger.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation

class AppLogger {
    static let shared = AppLogger()

    private init() {}

    func log(_ message: Any) {
        guard Constants.Settings.showLogs else { return }
        print("[LOG]: \(message)")
    }
}
