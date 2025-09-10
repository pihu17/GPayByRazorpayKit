#GPayByRazorpayKit

A Swift package for integrating Razorpay payments in iOS apps using SwiftUI.

#Features
 
1. Simple payment initiation via Razorpay
2. Customizable payment options (UPI, Card, Netbanking, Wallet, EMI, PayLater)
3. Retry support
4. Payment status updates via SwiftUI bindings
5. Success and error callbacks

#Installation

1. Add GPayByRazorpayKit to your Xcode project via Swift Package Manager.
2. Ensure the Razorpay iOS SDK is included as a dependency.

#Usage

**1. Import the Package
 
 import GPayByRazorpayKit

**2. Create a Payment Model

 var model = GPayPaymentModel(key: “fdhgsffhsfhsfh”, amount: 100, currency: "INR")
        model.description = "Service Fee"
        model.name = "Priyanka Jaiswal"
        model.contact = "9876543210"
        model.email = "priyanka@example.com"
        model.enableUPI = true
        model.enableEMI = false
        model.enableCard = false
        model.enableNetbanking = true
        model.retryEnabled = true
        model.retryMaxCount = 2

**3. Start Payment

***Use GPayPaymentHandler to initiate payment and handle results:

@StateObject private var paymentHandler = GPayPaymentHandler()

paymentHandler.onPaymentSuccessHandler = { paymentId, isSuccess in
    // Handle success
}

paymentHandler.onPaymentErrorHandler = { code, message, isSuccess in
    // Handle error
}

paymentHandler.startPayment(with: model)


**4. Observe Payment Status

***Bind to published properties for UI updates:
  
  isPaymentSuccessful
  isPaymentFail
  paymentID
  paymentFailCode
  paymentFailReason


#Example: SwiftUI  Integration  
struct ContentView: View {
    @State private var amountText: String = ""
    @State private var paymentStatus: String = ""
    @StateObject private var paymentHandler = GPayPaymentHandler()

    var body: some View {
        VStack {
            TextField("Enter amount", text: $amountText)
            Button("Pay Now") { startPayment() }
            Text(paymentStatus)
        }
    }

    private func startPayment() {
        guard let amount = Int(amountText) else {
            paymentStatus = "Invalid amount"
            return
        }
        var model = GPayPaymentModel(key: "...", amount: amount, currency: "INR")
        // Set other properties as needed
        paymentHandler.startPayment(with: model)
        paymentHandler.onPaymentSuccessHandler = { id, success in
            paymentStatus = "Success: \(id)"
        }
        paymentHandler.onPaymentErrorHandler = { code, msg, success in
            paymentStatus = "Error: \(msg)"
        }
    }
}


#API Reference

***GPayPaymentHandler*****

1. startPayment(with model: GPayPaymentModel)
2. Published properties for payment status
3. Success and error handler closures

***GPayPaymentModel*****

All payment configuration options (see struct definition)

***GPayPaymentConstants****

String keys for Razorpay options dictionary
