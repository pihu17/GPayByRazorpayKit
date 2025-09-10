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

    public override init() {
        super.init()
    }
    
    public func startPayment(with model: GPayPaymentModel) {
        
        razorpay = RazorpayCheckout.initWithKey(model.key, andDelegate: self)

        let options: [String: Any] = [
            GPayPaymentConstants.amount: model.amount * 100,
            GPayPaymentConstants.currency: model.currency,
            GPayPaymentConstants.description: model.description ?? "",
            GPayPaymentConstants.name: model.name ?? "",
            GPayPaymentConstants.profile: [
                GPayPaymentConstants.contact: model.contact ?? "",
                GPayPaymentConstants.email: model.email ?? ""
            ],
            GPayPaymentConstants.theme: [
                GPayPaymentConstants.color: model.themeColor
            ],
            GPayPaymentConstants.method: [
                GPayPaymentConstants.upi: model.enableUPI,
                GPayPaymentConstants.card: model.enableCard,
                GPayPaymentConstants.netbanking: model.enableNetbanking,
                GPayPaymentConstants.wallet: model.enableWallet,
                GPayPaymentConstants.emi: model.enableEMI,
                GPayPaymentConstants.paylater: model.enablePayLater
            ],
            GPayPaymentConstants.retry: [
                GPayPaymentConstants.enabled: model.retryEnabled,
                GPayPaymentConstants.maxCount: model.retryMaxCount
            ]
        ]
        razorpay.open(options)
    }
  
    // MARK: - RazorpayPaymentCompletionProtocol
    nonisolated
    public func onPaymentError(_ code: Int32, description str: String) {
        DispatchQueue.main.async {
            self.isPaymentFail = false
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

