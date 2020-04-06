//
//  GRPCLoggerModel.swift
//  Tix
//
//  Created by Wais Al Korni on 2/17/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import Foundation
import SwiftProtobuf

struct GRPCDebuggerModel {
  
  var identifier: String = String.randomString(length: 32)
  var requestHeader: [String: String] = [:]
  var method: String = "-"
  var requestBody: Message?
  var success: Bool? = nil
  var statusCode: StatusCode? = nil
  var statusMessage: String = "-"
  var responseBody: Message?
  var responseHeader: [String: String] = [:]
  var executionTime: TimeInterval = 0
  
  var executionTimeText: String {
    return String(format: "%.fms", executionTime)
  }
  
  var requestBodyString: String {
    guard let requestBody = requestBody else {
      return "-"
    }
    
    return "\(requestBody)"
  }

  var responseBodyString: String {
    guard let responseBody = responseBody else {
      return "-"
    }
    
    return "\(responseBody)"
  }
  
  var overview: [[String: String]] {
    let dateFormatter = DateFormatter()
    
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "MMM dd yyyy - HH:mm:ss"
    
    return [
      ["URL": method],
      ["Status Code": getStatusCode()],
      ["Status Message": statusMessage],
      ["Request Start Time": dateFormatter.string(from: Date())],
      ["Duration": executionTimeText]
    ]
  }
  
  func getRequestHeader() -> [[String: String]] {
    var header = [[String: String]]()
    for item in requestHeader {
      header.append([item.key: item.value])
    }
    
    return header
  }
  
  func getResponseHeader() -> [[String: String]] {
    var header = [[String: String]]()
    for item in responseHeader {
      header.append([item.key: item.value])
    }
    
    return header
  }
  
  private func getStatusCode() -> String {
    guard let statusCode = statusCode else {
      return "-"
    }
    
    return "\(statusCode.rawValue) (\(statusCode))"
  }
}

extension Data {
  
  var prettyPrintedJSONString: String? {
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
      let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
      let prettyPrintedString = String(data: data, encoding: String.Encoding.utf8) else {
        return nil
    }
    
    return prettyPrintedString
  }
}

extension String {
  
  static func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in
      (letters.randomElement() ?? Character(""))
    })
  }
}
