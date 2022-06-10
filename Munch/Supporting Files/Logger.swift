//
//  Logger.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//
import Foundation
import os.log

extension Logger {

    private static let subsystem = Bundle.main.bundleIdentifier!

    static let store = Logger(subsystem: subsystem, category: "Store")

    static let survey = Logger(subsystem: subsystem, category: "Surveys")

    static let feed = Logger(subsystem: subsystem, category: "Feed")
}
