//
//  GRPCDebuggerManager.swift
//  Tix
//
//  Created by Wais Al Korni on 2/17/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import Foundation

public final class GRPCDebuggerManager: NSObject {
  
  public static let shared = GRPCDebuggerManager()
  private var logs: [GRPCDebuggerModel] = [GRPCDebuggerModel]()
  
  public var enabled: Bool = false
  var logsDidUpdateHandler: (() -> Void)?
  
  func addModel(model: GRPCDebuggerModel) {
    logs.insert(model, at: 0)
    logsDidUpdateHandler?()
  }
  
  func updateModel(model: GRPCDebuggerModel) {
    for (index, listedModel) in logs.enumerated() {
      if model.identifier == listedModel.identifier {
        logs[index] = model
        logsDidUpdateHandler?()
        break
      }
    }
  }
  
  @objc func clearLogs() {
    logs.removeAll()
    logsDidUpdateHandler?()
  }
  
  func getLogs() -> [GRPCDebuggerModel] {
    return logs
  }
  
  func getBundle() -> Bundle{
      let podBundle = Bundle(for: GRPCDebuggerManager.classForCoder())
      if let bundleURL = podBundle.url(forResource: "GRPCDebuggerManager", withExtension: "bundle"){
          if let bundle = Bundle(url: bundleURL) {
              return bundle
          }
      }
      
      return Bundle(for: GRPCDebuggerManager.classForCoder())
  }
  
  public func showDebugger(viewController: UIViewController) {
    
    let navigationController = UINavigationController(rootViewController: GRPCDebuggerTableViewController(type: .list))
    navigationController.modalPresentationStyle = .fullScreen
    viewController.present(navigationController, animated: true, completion: nil)
  }
}
