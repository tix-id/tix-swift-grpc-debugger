//
//  GRPCAPIFactory+Orders.swift
//  Tix
//
//  Created by Seven on 7/1/19.
//  Copyright © 2019 Aliansi Teknologi Indonesia. All rights reserved.
//

import Foundation
import RxSwift
import SwiftProtobuf
import SwiftGRPCDebugger

enum CheckStatusType: String {
  case pending
  case insufficient
  case deadline
}

enum OrderService: GRPCServiceProtocol {

  case create(request: OrdersCreateReq)
  case cancel(request: OrdersCancelReq)
  case checkCreateStatus(request: OrdersCheckCreateStatusReq)
  case additionalInfo(request: OrdersAdditionalInfoReq)
  case checkoutURL(request: OrdersCheckoutURLReq)
  case getUpcomingOrder(request: OrdersUpcomingOrderReq)
  case getTransactionOrder(request: OrdersTransactionOrderReq)
  case getTicketDetail(request: OrdersTicketDetailReq)
  case checkTicketStatus(request: OrdersTicketCheckingReq)
  case changeOrderReadStatus(request: OrdersOrderChangingReadStatusReq)

  // swiftlint:disable function_body_length
  func execute() -> Observable<GRPCResult> {
    guard let client = client() as? OrdersEventOrdersServiceClient else {
      return Observable.empty()
    }

    return Observable.create({ (observer) -> Disposable in
      switch self {
      case .create(let input):
        _ = try? client.create(input, completion: { (response: OrdersCreateResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .cancel(request: let input):
        _ = try? client.cancel(input, completion: { (response: SwiftProtobuf.Google_Protobuf_Empty?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .checkCreateStatus(let input):
        _ = try? client.checkCreateStatus(input, completion: { (response: OrdersCheckCreateStatusResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .additionalInfo(let input):
        _ = try? client.additionalInfo(input, completion: { (response: SwiftProtobuf.Google_Protobuf_Empty?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .checkoutURL(let input):
        _ = try? client.checkoutURL(input, completion: { (response: OrdersCheckoutURLResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .getUpcomingOrder(let input):
        _ = try? client.getUpcomingOrder(input, completion: { (response: OrdersUpcomingOrderResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .getTransactionOrder(let input):
        _ = try? client.getTransactionOrder(input, completion: { (response: OrdersTransactionOrderResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .getTicketDetail(let input):
        _ = try? client.getTicketDetail(input, completion: { (response: OrdersTicketDetailResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .checkTicketStatus(let input):
        _ = try? client.checkTicketStatus(input, completion: { (response: OrdersTicketStatusResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .changeOrderReadStatus(let input):
        _ = try? client.changeOrderReadStatus(input, completion: { (response: OrdersOrderChangingReadStatusResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      }
      return Disposables.create()
    })
  }

  func client() -> ServiceClientBase? {
    return GRPCService.shared.orderClient?.setupHeader()
  }
}
