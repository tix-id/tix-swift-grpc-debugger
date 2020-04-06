//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: events.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import Dispatch
import SwiftProtobuf
import SwiftGRPCDebugger

internal protocol EventsEventsQueryEventListCall: ClientCallUnary {}

fileprivate final class EventsEventsQueryEventListCallBase: ClientCallUnaryBase<EventsQueryEventListReq, EventsQueryEventListResp>, EventsEventsQueryEventListCall {
  override class var method: String { return "/tix.service.Events/QueryEventList" }
}

internal protocol EventsEventsQueryEventDetailCall: ClientCallUnary {}

fileprivate final class EventsEventsQueryEventDetailCallBase: ClientCallUnaryBase<EventsQueryEventDetailReq, EventsQueryEventDetailResp>, EventsEventsQueryEventDetailCall {
  override class var method: String { return "/tix.service.Events/QueryEventDetail" }
}

internal protocol EventsEventsQueryEventTicketCall: ClientCallUnary {}

fileprivate final class EventsEventsQueryEventTicketCallBase: ClientCallUnaryBase<EventsQueryEventTicketReq, EventsQueryEventTicketResp>, EventsEventsQueryEventTicketCall {
  override class var method: String { return "/tix.service.Events/QueryEventTicket" }
}

internal protocol EventsEventsQueryEventInternalByIDCall: ClientCallUnary {}

fileprivate final class EventsEventsQueryEventInternalByIDCallBase: ClientCallUnaryBase<SwiftProtobuf.Google_Protobuf_Int64Value, EventsQueryEventInternalResp>, EventsEventsQueryEventInternalByIDCall {
  override class var method: String { return "/tix.service.Events/QueryEventInternalByID" }
}

internal protocol EventsEventsQueryEventTicketsInternalCall: ClientCallUnary {}

fileprivate final class EventsEventsQueryEventTicketsInternalCallBase: ClientCallUnaryBase<EventsQueryEventTicketsInternalReq, EventsQueryEventTicketsInternalResp>, EventsEventsQueryEventTicketsInternalCall {
  override class var method: String { return "/tix.service.Events/QueryEventTicketsInternal" }
}

internal protocol EventsEventsReleaseSeatInternalCall: ClientCallUnary {}

fileprivate final class EventsEventsReleaseSeatInternalCallBase: ClientCallUnaryBase<EventsReleaseSeatInternalReq, SwiftProtobuf.Google_Protobuf_Empty>, EventsEventsReleaseSeatInternalCall {
  override class var method: String { return "/tix.service.Events/ReleaseSeatInternal" }
}

internal protocol EventsEventsLockSeatInternalCall: ClientCallUnary {}

fileprivate final class EventsEventsLockSeatInternalCallBase: ClientCallUnaryBase<EventsLockSeatInternalReq, EventsLockSeatInternalResp>, EventsEventsLockSeatInternalCall {
  override class var method: String { return "/tix.service.Events/LockSeatInternal" }
}

internal protocol EventsEventsQueryEventDetailsInternalCall: ClientCallUnary {}

fileprivate final class EventsEventsQueryEventDetailsInternalCallBase: ClientCallUnaryBase<EventsQueryEventDetailsInternalReq, EventsQueryEventDetailsInternalResp>, EventsEventsQueryEventDetailsInternalCall {
  override class var method: String { return "/tix.service.Events/QueryEventDetailsInternal" }
}

internal protocol EventsEventsQueryEventTicketDetailsInternalCall: ClientCallUnary {}

fileprivate final class EventsEventsQueryEventTicketDetailsInternalCallBase: ClientCallUnaryBase<EventsQueryEventTicketDetailsInternalReq, EventsQueryEventTicketDetailsInternalResp>, EventsEventsQueryEventTicketDetailsInternalCall {
  override class var method: String { return "/tix.service.Events/QueryEventTicketDetailsInternal" }
}


/// Instantiate EventsEventsServiceClient, then call methods of this protocol to make API calls.
internal protocol EventsEventsService: ServiceClient {
  /// Synchronous. Unary.
  func queryEventList(_ request: EventsQueryEventListReq) throws -> EventsQueryEventListResp
  /// Asynchronous. Unary.
  func queryEventList(_ request: EventsQueryEventListReq, completion: @escaping (EventsQueryEventListResp?, CallResult) -> Void) throws -> EventsEventsQueryEventListCall

  /// Synchronous. Unary.
  func queryEventDetail(_ request: EventsQueryEventDetailReq) throws -> EventsQueryEventDetailResp
  /// Asynchronous. Unary.
  func queryEventDetail(_ request: EventsQueryEventDetailReq, completion: @escaping (EventsQueryEventDetailResp?, CallResult) -> Void) throws -> EventsEventsQueryEventDetailCall

  /// Synchronous. Unary.
  func queryEventTicket(_ request: EventsQueryEventTicketReq) throws -> EventsQueryEventTicketResp
  /// Asynchronous. Unary.
  func queryEventTicket(_ request: EventsQueryEventTicketReq, completion: @escaping (EventsQueryEventTicketResp?, CallResult) -> Void) throws -> EventsEventsQueryEventTicketCall

  /// Synchronous. Unary.
  func queryEventInternalByID(_ request: SwiftProtobuf.Google_Protobuf_Int64Value) throws -> EventsQueryEventInternalResp
  /// Asynchronous. Unary.
  func queryEventInternalByID(_ request: SwiftProtobuf.Google_Protobuf_Int64Value, completion: @escaping (EventsQueryEventInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventInternalByIDCall

  /// Synchronous. Unary.
  func queryEventTicketsInternal(_ request: EventsQueryEventTicketsInternalReq) throws -> EventsQueryEventTicketsInternalResp
  /// Asynchronous. Unary.
  func queryEventTicketsInternal(_ request: EventsQueryEventTicketsInternalReq, completion: @escaping (EventsQueryEventTicketsInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventTicketsInternalCall

  /// Synchronous. Unary.
  func releaseSeatInternal(_ request: EventsReleaseSeatInternalReq) throws -> SwiftProtobuf.Google_Protobuf_Empty
  /// Asynchronous. Unary.
  func releaseSeatInternal(_ request: EventsReleaseSeatInternalReq, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> EventsEventsReleaseSeatInternalCall

  /// Synchronous. Unary.
  func lockSeatInternal(_ request: EventsLockSeatInternalReq) throws -> EventsLockSeatInternalResp
  /// Asynchronous. Unary.
  func lockSeatInternal(_ request: EventsLockSeatInternalReq, completion: @escaping (EventsLockSeatInternalResp?, CallResult) -> Void) throws -> EventsEventsLockSeatInternalCall

  /// Synchronous. Unary.
  func queryEventDetailsInternal(_ request: EventsQueryEventDetailsInternalReq) throws -> EventsQueryEventDetailsInternalResp
  /// Asynchronous. Unary.
  func queryEventDetailsInternal(_ request: EventsQueryEventDetailsInternalReq, completion: @escaping (EventsQueryEventDetailsInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventDetailsInternalCall

  /// Synchronous. Unary.
  func queryEventTicketDetailsInternal(_ request: EventsQueryEventTicketDetailsInternalReq) throws -> EventsQueryEventTicketDetailsInternalResp
  /// Asynchronous. Unary.
  func queryEventTicketDetailsInternal(_ request: EventsQueryEventTicketDetailsInternalReq, completion: @escaping (EventsQueryEventTicketDetailsInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventTicketDetailsInternalCall

}

internal final class EventsEventsServiceClient: ServiceClientBase, EventsEventsService {
  /// Synchronous. Unary.
  internal func queryEventList(_ request: EventsQueryEventListReq) throws -> EventsQueryEventListResp {
    return try EventsEventsQueryEventListCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func queryEventList(_ request: EventsQueryEventListReq, completion: @escaping (EventsQueryEventListResp?, CallResult) -> Void) throws -> EventsEventsQueryEventListCall {
    return try EventsEventsQueryEventListCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func queryEventDetail(_ request: EventsQueryEventDetailReq) throws -> EventsQueryEventDetailResp {
    return try EventsEventsQueryEventDetailCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func queryEventDetail(_ request: EventsQueryEventDetailReq, completion: @escaping (EventsQueryEventDetailResp?, CallResult) -> Void) throws -> EventsEventsQueryEventDetailCall {
    return try EventsEventsQueryEventDetailCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func queryEventTicket(_ request: EventsQueryEventTicketReq) throws -> EventsQueryEventTicketResp {
    return try EventsEventsQueryEventTicketCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func queryEventTicket(_ request: EventsQueryEventTicketReq, completion: @escaping (EventsQueryEventTicketResp?, CallResult) -> Void) throws -> EventsEventsQueryEventTicketCall {
    return try EventsEventsQueryEventTicketCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func queryEventInternalByID(_ request: SwiftProtobuf.Google_Protobuf_Int64Value) throws -> EventsQueryEventInternalResp {
    return try EventsEventsQueryEventInternalByIDCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func queryEventInternalByID(_ request: SwiftProtobuf.Google_Protobuf_Int64Value, completion: @escaping (EventsQueryEventInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventInternalByIDCall {
    return try EventsEventsQueryEventInternalByIDCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func queryEventTicketsInternal(_ request: EventsQueryEventTicketsInternalReq) throws -> EventsQueryEventTicketsInternalResp {
    return try EventsEventsQueryEventTicketsInternalCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func queryEventTicketsInternal(_ request: EventsQueryEventTicketsInternalReq, completion: @escaping (EventsQueryEventTicketsInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventTicketsInternalCall {
    return try EventsEventsQueryEventTicketsInternalCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func releaseSeatInternal(_ request: EventsReleaseSeatInternalReq) throws -> SwiftProtobuf.Google_Protobuf_Empty {
    return try EventsEventsReleaseSeatInternalCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func releaseSeatInternal(_ request: EventsReleaseSeatInternalReq, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> EventsEventsReleaseSeatInternalCall {
    return try EventsEventsReleaseSeatInternalCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func lockSeatInternal(_ request: EventsLockSeatInternalReq) throws -> EventsLockSeatInternalResp {
    return try EventsEventsLockSeatInternalCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func lockSeatInternal(_ request: EventsLockSeatInternalReq, completion: @escaping (EventsLockSeatInternalResp?, CallResult) -> Void) throws -> EventsEventsLockSeatInternalCall {
    return try EventsEventsLockSeatInternalCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func queryEventDetailsInternal(_ request: EventsQueryEventDetailsInternalReq) throws -> EventsQueryEventDetailsInternalResp {
    return try EventsEventsQueryEventDetailsInternalCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func queryEventDetailsInternal(_ request: EventsQueryEventDetailsInternalReq, completion: @escaping (EventsQueryEventDetailsInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventDetailsInternalCall {
    return try EventsEventsQueryEventDetailsInternalCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func queryEventTicketDetailsInternal(_ request: EventsQueryEventTicketDetailsInternalReq) throws -> EventsQueryEventTicketDetailsInternalResp {
    return try EventsEventsQueryEventTicketDetailsInternalCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func queryEventTicketDetailsInternal(_ request: EventsQueryEventTicketDetailsInternalReq, completion: @escaping (EventsQueryEventTicketDetailsInternalResp?, CallResult) -> Void) throws -> EventsEventsQueryEventTicketDetailsInternalCall {
    return try EventsEventsQueryEventTicketDetailsInternalCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

}
