//
//  CovidStats.swift
//  SaniTech
//
//  Created by arian on 2/26/23.
//

import Foundation

struct Response: Codable {
    
    var casesByState: [CovidStats]
}

struct CovidStats: Codable {
    
    var range: String
    var casesReported: Int
    var name: String
}
