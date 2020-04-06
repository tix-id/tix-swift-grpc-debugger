//
//  GRPCAPIFactory+Events.swift
//  Tix
//
//  Created by Seven on 7/1/19.
//  Copyright © 2019 Aliansi Teknologi Indonesia. All rights reserved.
//

import Foundation
import RxSwift
import SwiftProtobuf
import SwiftGRPCDebugger

enum EventService: GRPCServiceProtocol {

  case eventList(request: EventsQueryEventListReq)
  case eventDetail(request: EventsQueryEventDetailReq)
  case eventTicket(request: EventsQueryEventTicketReq)
  case releaseSeatInternal(request: EventsReleaseSeatInternalReq)

  func execute() -> Observable<GRPCResult> {
    guard let client = client() as? EventsEventsServiceClient else {
      return Observable.empty()
    }

    return Observable.create({ (observer) -> Disposable in
      switch self {
      case .eventList(let input):
        _ = try? client.queryEventList(input, completion: { (response: EventsQueryEventListResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .eventDetail(let input):
        _ = try? client.queryEventDetail(input, completion: { (response: EventsQueryEventDetailResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .eventTicket(let input):
        _ = try? client.queryEventTicket(input, completion: { (response: EventsQueryEventTicketResp?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      case .releaseSeatInternal(let input):
        _ = try? client.releaseSeatInternal(input, completion: { (response: SwiftProtobuf.Google_Protobuf_Empty?, callResult: CallResult) in
          observer.onNext((response, callResult))
          observer.onCompleted()
        })
      }
      return Disposables.create()
    })
  }

  func client() -> ServiceClientBase? {
    return GRPCService.shared.eventClient?.setupHeader()
  }
}
