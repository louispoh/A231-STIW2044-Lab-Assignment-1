import 'package:flutter/material.dart';
import 'dart:math';

class MainCalc extends StatefulWidget {
  const MainCalc({super.key});

  @override
  State<MainCalc> createState() => _MainCalcState();
}

class _MainCalcState extends State<MainCalc> {
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController termEditingController = TextEditingController();
  TextEditingController interestEditingController = TextEditingController();
  double loanAmount = 0;
  int loanTerm = 0;
  double interestRate = 0;
  double result = 0.0;
  int duration = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loan Calculator")),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/calculator splash page.jpeg',
              ),
              const Text(
                "LOAN PAYMENTS CALCULATOR",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountEditingController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    hintText: "Enter Loan Amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: termEditingController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    hintText: "Loan Term",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: interestEditingController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    hintText: "Interest Rate",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: calLOAN,
                child: const Text("Calculate"),
              ),
              if (result != 0.0)
                Column(
                  children: [
                    const SizedBox(height: 10), // Add some spacing
                    Text("Monthly Payment: RM ${result.toStringAsFixed(2)}"),

                    const SizedBox(height: 10), // Add some spacing
                    Text(
                      "You will need to pay RM ${result.toStringAsFixed(2)} every month for $duration years to payoff the debt.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

              // Builder(
              //   builder: (context) => ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const MainCalc()));
              //     },
              //     child: const Text('Press ME'),
              //   ),
              // )
            ],
          ),
        )),
      ),
    );
  }

  void calLOAN() {
    // Get user inputs from text controllers
    double loanAmount = double.tryParse(amountEditingController.text) ?? 0.0;
    int loanTerm = int.tryParse(termEditingController.text) ?? 0;
    double interestRate =
        double.tryParse(interestEditingController.text) ?? 0.0;

    int duration = 0;

    // Validate user inputs
    if (loanAmount <= 0 || loanTerm <= 0 || interestRate <= 0) {
      // Handle invalid input gracefully, such as displaying an error message.
      return;
    }

    // Convert annual interest rate to monthly interest rate
    double monthlyInterestRate = (interestRate / 100) / 12;

    // Calculate the total number of monthly payments
    int totalPayments = loanTerm * 12;

    // Calculate the monthly payment
    double monthlyPayment = (loanAmount *
            monthlyInterestRate *
            pow(1 + monthlyInterestRate, totalPayments)) /
        (pow(1 + monthlyInterestRate, totalPayments) - 1);

    // Update the state with the calculated result
    setState(() {
      result = monthlyPayment;
      duration = loanTerm;
    });

    print(result);
  }
}
