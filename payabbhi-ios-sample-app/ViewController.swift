//
//  ViewController.swift
//  payabbhi-ios-sample-app
//
//  Created by Shreya Ganguly on 20/07/18.
//  Copyright © 2018 Paypermint. All rights reserved.
//

import UIKit
// import Payabbhi module, to use payabbhi-ios SDK in your app
import Payabbhi

/** Your ViewController needs to implement PaymentCallback to receive callbacks for the Payment response and error. */
class ViewController: UIViewController, PaymentCallback {
    var payabbhi : Payabbhi!

    var options = [String: Any]()

    var amount = Float(1)

    override func viewDidLoad() {
        super.viewDidLoad()

        /** Instantiate Payabbhi with access_id */
        payabbhi = Payabbhi(accessID: "<ACCESS-ID>", delegate: self)

        /** After instantiating Payabbhi, you will need to pass the Checkout Configuration options specified in https://payabbhi.com/docs/checkout/#configuration-options as a Dictionary. The configuration options in checkout.js are also applicable to iOS */
         options =  [
           /**
           * It is expected that the Mobile Backend (server-side code) would create an Order using Payabbhi [Order API](/docs/api/#create-an-order)
           * and pass the unique `order_id` to the App.
           * This unique `order_id` should be passed by your App to the `Payabbhi` object to initiate Checkout.
           */
            "order_id": "<unique-order-id>",

            /** Order amount in paisa (e.g., 5000 paisa = Rs 50.00) */
            "amount": <order-amount>,

            "name":"Payabbhi",
            "description": "Live Demo",
            "image": "https://payabbhi.com/demo/assets/images/logo.jpg",
            "prefill": [
                "name":"Bruce Wayne",
                "email": "bruce@wayneinc.com",
                "contact": "827726862552"
            ]
            ] as [String : Any]

        self.amount = Float(options["amount"] as! Int)/Float(100)

        payBtntext.backgroundColor = UIColor(red: CGFloat(72.0/255.0), green: CGFloat(62.0/255.0), blue: CGFloat(119.0/255.0), alpha: 1.0)
        payBtntext.setTitleColor(UIColor(red: CGFloat(44.0/255.0), green: CGFloat(228.0/255.0), blue: CGFloat(115.0/255.0), alpha: 1.0), for: UIControl.State.normal)
        payBtntext.layer.cornerRadius = 25
        payBtntext.setTitle(String(format: "PAY ₹%.2f", self.amount), for: UIControl.State.normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var payBtntext: UIButton!

    @IBAction func payBtnPressed(_ sender: Any) {
        /* Instantiate Payabbhi by passing Access ID obtained from Payabbhi Merchant Portal */
        let err = payabbhi.open(options: options)
        if err != nil {
            /**
             * Add your logic here to handle if there is any error while opening the checkout form.
             */
            showAlert(title: "Error Occured!", message: "Code: \(String(describing: err?.getCode())), Message: \(String(describing: err?.getMessage()))", buttonTitle: "OK")
        }

    }
    func onPaymentSuccess(paymentResponse: PaymentResponse) {
        /**
         * Add your logic here to process the Payment response on successful payment
         * It is expected that you would pass the Payment response
         * to your Mobile Backend (Server-side code) for further processing
         * Refer https://payabbhi.com/docs/integration/#verification-of-payment-response to see how to verify payment response.
         */
        showAlert(title: "Payment Successful!", message: "Payment ID:  \(paymentResponse.getPaymentID())", buttonTitle: "Start Over")
    }

    func onPaymentError(code: Int, message: String) {
        /**
         * Add your logic here to handle scenarios where the Checkout did not result in a successful Payment
         */
        showAlert(title: "Error Occured!", message: "Code: \(code), Message: \(message) ", buttonTitle: "OK")
    }

    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
