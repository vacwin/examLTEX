//
//  APIInfo.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
public struct APIInfo {
    private static let baseUrl = "http://dev-exam.l-tech.ru/api"
    public static var baseApiUrl: String { get { return self.baseUrl + "/v1" } }
    public static var netowrkUrl: String { get { return APIInfo.baseApiUrl + "/phone_masks"} }
    public static var authUrl: String { get { return APIInfo.baseApiUrl + "/auth" } }
}
