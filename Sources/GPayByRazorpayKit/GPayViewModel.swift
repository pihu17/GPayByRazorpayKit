//
//  GPayViewModel.swift
//  GPayByRazorpayKit
//
//  Created by PRIYANKA JAISWAL on 12/09/25.
//
import Foundation
import Razorpay

public struct GPayPaymentModel {
    
    // Mandatory fields
    public var key: String
    public var amount: Int
    public var currency: String

    // Optional fields with default values
    public var description: String?
    public var name: String?
    public var contact: String?
    public var email: String?

    // Payment method flags with default values
    public var enableUPI: Bool
    public var enableCard: Bool
    public var enableNetbanking: Bool
    public var enableWallet: Bool
    public var enableEMI: Bool
    public var enablePayLater: Bool
    public var themeColor: String
    
    // Retry options with default values
    public var retryEnabled: Bool
    public var retryMaxCount: Int

    public init(
        key: String,
        amount: Int,
        currency: String,
        description: String? = nil,
        name: String? = nil,
        contact: String? = nil,
        email: String? = nil,
        enableUPI: Bool = true,
        enableCard: Bool = true,
        enableNetbanking: Bool = true,
        enableWallet: Bool = true,
        enableEMI: Bool = true,
        themeColor: String = "#FAA4BD",
        enablePayLater: Bool = true,
        retryEnabled: Bool = true,
        retryMaxCount: Int = 2
    ) {
        self.key = key
        self.amount = amount
        self.currency = currency
        self.description = description
        self.name = name
        self.contact = contact
        self.email = email
        self.enableUPI = enableUPI
        self.enableCard = enableCard
        self.enableNetbanking = enableNetbanking
        self.enableWallet = enableWallet
        self.enableEMI = enableEMI
        self.enablePayLater = enablePayLater
        self.themeColor = themeColor
        self.retryEnabled = retryEnabled
        self.retryMaxCount = retryMaxCount
    }
}
