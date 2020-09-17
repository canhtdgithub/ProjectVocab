//
//  BundleExtention.swift
//  TemplateProject
//
//  Created by Hoa on 7/1/19.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation

extension Bundle {
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }
    var bundleId: String {
        return bundleIdentifier!
    }
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
}
