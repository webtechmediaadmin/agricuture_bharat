import 'package:agriculter_bharat/constant/helper.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPayment extends StatefulWidget {
  const RazorPayPayment({super.key});

  @override
  State<RazorPayPayment> createState() => _RazorPayPaymentState();
}

class _RazorPayPaymentState extends State<RazorPayPayment> {
  late Razorpay _razorpay;
  TextEditingController amountController = TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;

    var options = {
      'key': '',
      'amount': amount,
      'name': 'Geeks for Geeks',
      'prefill': {'contact': '9971890157', 'email': 'test@gmail.com'},
      'externals': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options); 
    } catch (e) {
      print(e); 
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    showSnackBar('', 'Payment Successful${response.paymentId!}');
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    showSnackBar('', 'Payment Successful${response.message}');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    showSnackBar('', 'Payment Successful${response.walletName}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.network(
              '', width: 300,
            ),
            const SizedBox(height: 10,),
            Text("Welcome to Razorpay Payment Gateway Integration", style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18
            ),
            textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter amount to be paid',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0
                    )
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
                ),
                controller: amountController,
                validator: (value){
                  if(value!.isEmpty || value == null ){
                    return "Please enter amount to be paid.";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if(amountController.text.toString().isNotEmpty){
                  setState(() {
                    int amount = int.parse(amountController.text.toString());
                    openCheckout(amount);
                  });
                }
              }, 
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Make Payment"),
              )
            )
          ],
        ),
      ),
    );
  }
}