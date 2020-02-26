/*
 * Copyright 2018, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/*
 * Modified for GRPC Logger Purpose by TIX ID
 */

import Dispatch
import Foundation
import SwiftProtobuf

public protocol ClientCallUnary: ClientCall {}

open class ClientCallUnaryBase<InputType: Message, OutputType: Message>: ClientCallBase, ClientCallUnary {
  /// Run the call. Blocks until the reply is received.
  /// - Throws: `BinaryEncodingError` if encoding fails. `CallError` if fails to call. `RPCError` if receives no response.
  public func run(request: InputType, metadata: Metadata) throws -> OutputType {
    let sem = DispatchSemaphore(value: 0)
    var returnCallResult: CallResult!
    var returnResponse: OutputType?
    _ = try start(request: request, metadata: metadata) { response, callResult in
      returnResponse = response
      returnCallResult = callResult
      sem.signal()
    }
    _ = sem.wait()
    if let returnResponse = returnResponse {
      return returnResponse
    } else {
      throw RPCError.callError(returnCallResult)
    }
  }

  /// Start the call. Nonblocking.
  /// - Throws: `BinaryEncodingError` if encoding fails. `CallError` if fails to call.
  public func start(request: InputType,
                    metadata: Metadata,
                    completion: @escaping ((OutputType?, CallResult) -> Void)) throws -> Self {
    
    var loggerModel = GRPCDebuggerModel()
    if GRPCDebuggerManager.shared.enabled {
      loggerModel.requestHeader = metadata.dictionaryRepresentation
      loggerModel.requestBody = try request.jsonString()
      loggerModel.method = type(of: self).method
      GRPCDebuggerManager.shared.addModel(model: loggerModel)
    }
    
    let methodStartDate = Date()
    
    let requestData = try request.serializedData()
    try call.start(.unary, metadata: metadata, message: requestData) { callResult in
      if GRPCDebuggerManager.shared.enabled {
        let methodFinishDate = Date()
        let executionTime = methodFinishDate.timeIntervalSince(methodStartDate) * 1000 // Convert to milliseconds
        loggerModel.executionTime = executionTime
        loggerModel.success = callResult.success
        loggerModel.statusCode = callResult.statusCode
        
        let statusMessage = (callResult.statusMessage ?? "-")
        loggerModel.statusMessage = statusMessage == "" ? "-" : statusMessage
        loggerModel.responseHeader = (callResult.initialMetadata?.dictionaryRepresentation ?? [:])
      }
      
      if let responseData = callResult.resultData {
        let outputType = try? OutputType(serializedData: responseData)
        
        if GRPCDebuggerManager.shared.enabled {
          do {
            loggerModel.responseBody = try outputType?.jsonString() ?? "-"
            GRPCDebuggerManager.shared.updateModel(model: loggerModel)
          } catch {}
        }
        
        completion(outputType, callResult)
      } else {
        if GRPCDebuggerManager.shared.enabled {
          GRPCDebuggerManager.shared.updateModel(model: loggerModel)
        }
        completion(nil, callResult)
      }
    }
    return self
  }
}

/// Simple fake implementation of `ClientCallUnary`.
open class ClientCallUnaryTestStub: ClientCallUnary {
  open class var method: String { fatalError("needs to be overridden") }

  public init() {}

  open func cancel() {}
}
