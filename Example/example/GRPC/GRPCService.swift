//
//  GRPCService.swift
//  Tix
//
//  Created by Wais Al Korni on 6/27/19.
//  Copyright © 2019 Aliansi Teknologi Indonesia. All rights reserved.
//

import Foundation
import SwiftProtobuf
import RxSwift
import SwiftGRPCDebugger

typealias GRPCResult = (message: Message?, callResult: CallResult)

protocol GRPCServiceProtocol {

  func execute() -> Observable<GRPCResult>
  func client() -> ServiceClientBase?
}

enum GRPCErrorType: String {
  case preconditionFailure = "type.googleapis.com/google.rpc.PreconditionFailure"
  case badRequest = "type.googleapis.com/google.rpc.BadRequest"
}

final class GRPCService {

  static let shared = GRPCService()
  private init() {
    createEventClient()
    createOrderClient()
  }
  
  static let eventAddress = "grpc-stg.tix.id:443"
  
  var eventClient: EventsEventsServiceClient?
  var orderClient: OrdersEventOrdersServiceClient?
  
  static let retryRequestLimit = 4
  private let disposeBag = DisposeBag()
  
  static func getCertificate() -> String {
    guard let certificateURL = Bundle.main.url(forResource: "TixCerts", withExtension: "crt") else {
      return ""
    }
    
    do {
      let certificates = try String(contentsOf: certificateURL)
      return certificates
    } catch {
      return ""
    }
  }

  func connect(service: GRPCServiceProtocol) -> Observable<Message?> {
    let subject = ReplaySubject<Message?>.createUnbounded()
    subject.disposed(by: disposeBag)

//    if !NetworkService.shared.isConnectedToInternet {
//      subject.onError(TixAPIError.noInternetConnection)
//      subject.onCompleted()
//    }
    
    executeRequest(service: service, subject: subject, retryCount: 0)
    return subject.do()
  }
  
  private func executeRequest(service: GRPCServiceProtocol, subject: ReplaySubject<Message?>, retryCount: Int) {
    _ = service.execute().observeOn(MainScheduler.instance).subscribe { [weak self] (grpcResult: Event<GRPCResult>) in
      let hasMiddlewareError = (self?.handleMiddlewareError(subject: subject, grpcResult: grpcResult) ?? false)
      
      guard let statusCode = grpcResult.element?.callResult.statusCode, !hasMiddlewareError else {
        return
      }
      
      let message = grpcResult.element?.callResult.statusMessage
      
      switch statusCode {
      case .ok:
        subject.onNext(grpcResult.element?.message)
        subject.onCompleted()
      case .unauthenticated:
        break
//        subject.onError(TixAPIError.connectionError(code: ConnectionErrorCodeType.unauthorized.rawValue, message: message))
      case .cancelled, .unavailable, .aborted:
        if retryCount < GRPCService.retryRequestLimit {
          DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(retryCount + 1)) {
            self?.executeRequest(service: service, subject: subject, retryCount: retryCount + 1)
          }
        } else {
//          subject.onError(TixAPIError.connectionError(code: ConnectionErrorCodeType.grpcError.rawValue, message: message))
        }
      default:
        break
//        subject.onError(TixAPIError.connectionError(code: ConnectionErrorCodeType.grpcError.rawValue, message: message))
      }
    }.disposed(by: disposeBag)
  }

  private func handleMiddlewareError(subject: ReplaySubject<Message?>, grpcResult: Event<GRPCResult>) -> Bool {
    guard let metadata = grpcResult.element?.callResult.trailingMetadata?.data(forKey: "grpc-status-details-bin"),
      let grpcStatus = try? Google_Rpc_Status(serializedData: metadata), !grpcStatus.details.isEmpty else {
        return false
    }

    for errorDetail in grpcStatus.details {
      guard let grpcErrorType = GRPCErrorType(rawValue: errorDetail.typeURL) else {
        continue
      }

      switch grpcErrorType {
      case .preconditionFailure:
        guard let tixError = try? Google_Rpc_PreconditionFailure(serializedData: errorDetail.value),
          let tixErrorInfo = tixError.violations.first else {
            return false
        }

//        subject.onError(TixAPIError.middlewareGRPCError(type: tixErrorInfo.type,
//                                                        subject: tixErrorInfo.subject,
//                                                        message: tixErrorInfo.description_p))
        return true
      case .badRequest:
        guard let badRequestError = try? Google_Rpc_BadRequest(serializedData: errorDetail.value),
          let badRequestInfo = badRequestError.fieldViolations.first else {
            return false
        }

//        subject.onError(TixAPIError.connectionError(code: ConnectionErrorCodeType.badRequest.rawValue,
//                                                    message: badRequestInfo.description_p))
        return true
      }
    }

    return false
  }
  
  private func observeEventChannelState() {
    eventClient?.channel.addConnectivityObserver { [weak self] (state) in
      if state == .shutdown {
        self?.createEventClient()
      } else if state == .idle || state == .transientFailure || state == .unknown {
        _ = self?.eventClient?.channel.connectivityState(tryToConnect: true)
      }
    }
  }

  private func observeOrderChannelState() {
    orderClient?.channel.addConnectivityObserver { [weak self] (state) in
      if state == .shutdown {
        self?.createOrderClient()
      } else if state == .idle || state == .transientFailure || state == .unknown {
        _ = self?.orderClient?.channel.connectivityState(tryToConnect: true)
      }
    }
  }
  
  private func createEventClient() {
    eventClient = EventsEventsServiceClient.init(address: GRPCService.eventAddress, certificates: GRPCService.getCertificate())
    observeEventChannelState()
  }
  
  private func createOrderClient() {
    orderClient = OrdersEventOrdersServiceClient.init(address: GRPCService.eventAddress, certificates: GRPCService.getCertificate())
    observeOrderChannelState()
  }
}

extension ServiceClientBase {

  func setupHeader() -> ServiceClientBase {
    let currentLanguage = "id"
    let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtc2lzZG4iOiIrNjI4NTY5NDg0OTkyNSIsInVzZXJfaWQiOiI5NTUwOTg4MDYyMDUwMjYzMDQiLCJhdXRoX3NpZ24iOiIiLCJwdXJwb3NlIjoibG9naW4iLCJhdWQiOiJUaXhJRCBNaWRkbGV3YXJlIiwiZXhwIjoxNTk0NzgxMTQ5LCJpYXQiOjE1ODYxNDExNDksImlzcyI6IlRpeElEIFNlY3VyaXR5IEF1dGhvcml0eSIsInN1YiI6Ik1vYmlsZSBhdXRob3JpemF0aW9uIHRva2VuIn0.ZIxH3SJBisfEHK-Te0paWiYBid3DbpfiMWx5apznNSk"

    guard let metadata = try? Metadata(["accept-language": currentLanguage,
                                        "authorization": "Bearer \(token)"]) else {
                                          return self
    }

    self.metadata = metadata

    return self
  }
}
