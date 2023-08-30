//
//  PaymentDetailsRequest.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

struct PaymentDetailsRequest: Request {
    var urlRequest: URLRequest {
        return .init(url: Configuration.baseURL.appendingPathComponent(PaymentDetailsEndPoint.PaymentDetails))
    }
}
