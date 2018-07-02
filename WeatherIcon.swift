//
//  WeatherIcon.swift
//  Ajman.Go
//
//  Created by Musa Almatri on 7/1/18.
//  Copyright © 2018 Quicklink. All rights reserved.
//

import UIKit

class WeatherIcon {

    static func loadIcon(_ id: Int, day: Bool = false, night: Bool = false) -> String? {
        let filePath = Bundle.main.path(forResource: "WeatherIcons", ofType: "json", inDirectory: nil)
        
        if let filePath = filePath {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let json = try? JSONSerialization.jsonObject(with: jsonData)
                if let icons = json as? [[String: Any]] {
                    var d: [String: Any] = [:]
                    for icon in icons where icon.first?.key != nil {
                        if let name = icon["name"] as? String {
                            d[name] = icon["icon"]
                        }
                    }
                    if day {
                        return d["wi_owm_day_\(id)"] as? String
                    } else if night {
                        return d["wi_owm_night_\(id)"] as? String
                    } else {
                        return d["wi_owm_\(id)"] as? String
                    }
                }
            } catch {
                print(error)
                fatalError("Unable to read contents of the file url")
            }
        }
        
        return ""
    }
}
