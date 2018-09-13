# Payabbhi iOS Sample App

This is a reference app for enabling Payments acceptance in your iOS App using [Payabbhi iOS SDK](https://payabbhi.com/docs/mobile-checkout/ios).

For Integration guide, refer to [Mobile Checkout - iOS](https://payabbhi.com/docs/mobile-checkout/ios).

## Specifications

* App Specifications

  - Language Used: `Swift`
  - Xcode Version: `9.4`

* Framework Specifications  

  - Framework Version: `9.3`

### Run the Sample App

Make sure you have signed up for your [Payabbhi Account](https://payabbhi.com/docs/account) and downloaded the [API keys](https://payabbhi.com/docs/account/#api-keys) from the [Portal](https://payabbhi.com/portal).

- Clone the project

- Replace `<ACCESS-ID>` with your Access ID in `ViewController.swift`

- Add logic to get `order_id` from your Mobile Backend (server-side code) in `ViewController.swift`

    > TIP: An alternative to having a Mobile Backend for running the sample App is:
    > 1. Generate a unique order_id using curl
    > 2. Copy/paste the generated order_id in `ViewController.swift`
    > 3. Once a successful test transaction is completed for a particular order, repeat the above steps

    ```
    curl https://payabbhi.com/api/v1/orders \
      -u access_id:secret_key \
      -d amount=100 \
      -d merchant_order_id=ordRefNo123456 \
      -d currency=INR
    ```

- Pass suitable values in Checkout options in `ViewController.swift` e.g. `<order-amount>` as per Order.amount
