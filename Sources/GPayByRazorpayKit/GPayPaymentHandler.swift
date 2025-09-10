//
//  GPayPaymentHandler.swift
//  GPayByRazorpayKit
//
//  Created by PRIYANKA JAISWAL on 10/09/25.
//
import Foundation
import SwiftUI
import Razorpay

@MainActor
public final class GPayPaymentHandler: NSObject, RazorpayPaymentCompletionProtocol, ObservableObject {

    @Published public var isPaymentSuccessful = false
    @Published public var isPaymentFail = false
    @Published public var paymentID: String?
    @Published public var paymentFailCode: Int?
    @Published public var paymentFailReason: String?
    
    public var onPaymentErrorHandler: ((Int, String, Bool) -> Void)?
    public var onPaymentSuccessHandler: ((String, Bool) -> Void)?

    private var razorpay: RazorpayCheckout!

    public init(key: String) {
        super.init()
        razorpay = RazorpayCheckout.initWithKey(key, andDelegate: self)
    }

    public func startPayment(price: Int) {
        let options: [String: Any] = [
            "amount": "\(price * 100)",
            "currency": "INR",
            "description": "Test Payment",
            "name": "GPay By Razorpay",
            "prefill": ["contact": "1234567890", "email": "test@example.com"],
            "theme": ["color": "#FAA4BD"],
            "method": ["upi": true]
        ]
        razorpay.open(options)
    }

    // MARK: - RazorpayPaymentCompletionProtocol
    nonisolated
    public func onPaymentError(_ code: Int32, description str: String) {
        DispatchQueue.main.async {
            self.isPaymentFail = true
            self.paymentFailCode = Int(code)
            self.paymentFailReason = str
            self.onPaymentErrorHandler?(self.paymentFailCode ?? 0, self.paymentFailReason ?? "", self.isPaymentFail)
        }
    }


    nonisolated
    public func onPaymentSuccess(_ payment_id: String) {
        DispatchQueue.main.async {
            self.isPaymentSuccessful = true
            self.paymentID = payment_id
            self.onPaymentSuccessHandler?(self.paymentID ?? "", self.isPaymentSuccessful)
        }
    }
}

