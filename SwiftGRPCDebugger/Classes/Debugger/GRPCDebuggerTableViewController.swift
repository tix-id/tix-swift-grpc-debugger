//
//  GRPCDebuggerTableViewController.swift
//  Tix
//
//  Created by Wais Al Korni on 2/18/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import UIKit

enum DebuggerSectionType: Int, CaseIterable {
  case overview = 0
  case requestHeader
  case requestBody
  case responseHeader
  case responseBody
  
  func sectionTitle() -> String {
    switch self {
    case .overview:
      return "Overview"
    case .requestHeader:
      return "Request Header"
    case .requestBody:
      return "Request Body"
    case .responseHeader:
      return "Response Header"
    case .responseBody:
      return "Response Body"
    }
  }
  
  func rowsNumber(model: GRPCDebuggerModel?) -> Int {
    guard let model = model else {
      return 0
    }
    
    switch self {
    case .overview:
      return model.overview.count
    case .requestHeader:
      return model.requestHeader.count
    case .requestBody, .responseBody:
      return 1
    case .responseHeader:
      return model.responseHeader.count
    }
  }
  
  func getDatasource(model: GRPCDebuggerModel?) -> [[String: String]] {
    guard let model = model else {
      return [["": ""]]
    }
    
    switch self {
    case .overview:
      return model.overview
    case .requestHeader:
      return model.getRequestHeader()
    case .responseHeader:
      return model.getResponseHeader()
    case .requestBody:
      return [["content": model.requestBody]]
    case .responseBody:
      return [["content": model.responseBody]]
    }
  }
}

enum DebuggerTableViewType {
  case list
  case detail
  
  func sectionNumber() -> Int {
    switch self {
    case .list:
      return 1
    case .detail:
      return DebuggerSectionType.allCases.count
    }
  }
  
  func rowsNumber(section: Int, debuggerModel: GRPCDebuggerModel?) -> Int {
    switch self {
    case .list:
      return GRPCDebuggerManager.shared.getLogs().count
    case .detail:
      guard let sectionType = DebuggerSectionType(rawValue: section) else {
        return 0
      }
      
      return sectionType.rowsNumber(model: debuggerModel)
    }
  }
  
  func rowHeight() -> CGFloat {
    switch self {
    case .list:
      return 64
    case .detail:
      return UITableView.automaticDimension
    }
  }
}

final class GRPCDebuggerTableViewController: UITableViewController {
  
  private let tableViewType: DebuggerTableViewType
  private let selectedItem: GRPCDebuggerModel?
  
  private let sectionHeight: CGFloat = 30
  
  init(type: DebuggerTableViewType, selectedItem: GRPCDebuggerModel? = nil) {
    tableViewType = type
    self.selectedItem = selectedItem
    
    super.init(nibName: "GRPCDebuggerTableViewController", bundle: GRPCDebuggerManager.shared.getBundle())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    subscribeDatasource()
    tableView.separatorStyle = .none
    let bundle = GRPCDebuggerManager.shared.getBundle()
    
    tableView.register(UINib(nibName: "GRPCDebuggerTableViewCell", bundle: bundle), forCellReuseIdentifier: String(describing: GRPCDebuggerTableViewCell.self))
    tableView.register(UINib(nibName: "GRPCDebuggerBodyTableViewCell", bundle: bundle), forCellReuseIdentifier: String(describing: GRPCDebuggerBodyTableViewCell.self))
    tableView.register(UINib(nibName: "GRPCDebuggerDetailTableViewCell", bundle: bundle), forCellReuseIdentifier: String(describing: GRPCDebuggerDetailTableViewCell.self))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupNavigationItems()
  }
  
  private func setupNavigationItems() {
    switch tableViewType {
    case .list:
      title = "Requests"
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearLogs))
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeDebugger))
    case .detail:
      title = "Details"
      navigationItem.leftBarButtonItem = nil
      navigationItem.rightBarButtonItem = nil
    }
  }
  
  @objc private func closeDebugger() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func clearLogs() {
    GRPCDebuggerManager.shared.clearLogs()
  }
  
  private func subscribeDatasource() {
    GRPCDebuggerManager.shared.logsDidUpdateHandler = { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
  
  private func createListCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GRPCDebuggerTableViewCell.self), for: indexPath) as? GRPCDebuggerTableViewCell else {
      return UITableViewCell()
    }
    
    cell.configure(model: GRPCDebuggerManager.shared.getLogs()[indexPath.row])
    cell.selectionStyle = .none
    
    return cell
  }
  
  private func createDetailCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    guard let sectionType = DebuggerSectionType(rawValue: indexPath.section),
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GRPCDebuggerDetailTableViewCell.self), for: indexPath) as? GRPCDebuggerDetailTableViewCell else {
        return UITableViewCell()
    }
    
    switch sectionType {
    case .overview, .requestHeader, .responseHeader:
      let key = (sectionType.getDatasource(model: selectedItem)[indexPath.row].keys.first ?? "")
      let value = (sectionType.getDatasource(model: selectedItem)[indexPath.row].values.first ?? "")
      
      cell.configure(title: key, message: value)
      cell.selectionStyle = .none
      return cell
    case .requestBody, .responseBody:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GRPCDebuggerBodyTableViewCell.self), for: indexPath) as? GRPCDebuggerBodyTableViewCell else {
        return UITableViewCell()
      }
      
      cell.selectionStyle = .none
      return cell
    }
  }
  
  private func showBodyDetail(indexPath: IndexPath) {
    guard let sectionType = DebuggerSectionType(rawValue: indexPath.section),
      let selectedItem = selectedItem else {
        return
    }
    
    var content: String? = nil
    
    switch sectionType {
    case .requestBody:
      content = selectedItem.requestBodyJson
    case .responseBody:
      content = selectedItem.responseBodyJson
    default:
      return
    }
    
    guard let jsonContent = content, !jsonContent.isEmpty else {
      return
    }
    
    let bodyViewController = GRPCDebuggerBodyViewController(content: jsonContent, sectionType: sectionType)
    navigationController?.pushViewController(bodyViewController, animated: true)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewType.sectionNumber()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewType.rowsNumber(section: section, debuggerModel: selectedItem)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableViewType.rowHeight()
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 21
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch tableViewType {
    case .list:
      return createListCell(tableView: tableView, indexPath: indexPath)
    case .detail:
      return createDetailCell(tableView: tableView, indexPath: indexPath)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch tableViewType {
    case .list:
      return 0
    case .detail:
      return sectionHeight
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard tableViewType == .detail, let sectionType = DebuggerSectionType(rawValue: section) else {
      return nil
    }
    
    let padding: CGFloat = 20
    let containerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: sectionHeight))
    containerView.backgroundColor = UIColor(red: 235.0/255.0, green: 236.0/255.0, blue: 238.0/255.0, alpha: 1)
    
    let sectionLabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - padding * 2, height: sectionHeight))
    sectionLabel.text = sectionType.sectionTitle()
    sectionLabel.font = UIFont.systemFont(ofSize: 14)
    containerView.addSubview(sectionLabel)
    
    return containerView
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch tableViewType {
    case .list:
      let detailViewController = GRPCDebuggerTableViewController(type: .detail,
                                                                 selectedItem: GRPCDebuggerManager.shared.getLogs()[indexPath.row])
      navigationController?.pushViewController(detailViewController, animated: true)
    case .detail:
      showBodyDetail(indexPath: indexPath)
    }
  }
}
