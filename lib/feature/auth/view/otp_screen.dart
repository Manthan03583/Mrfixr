//import 'dart:math';
import 'package:demandium/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late String generatedOtp;

  final otpController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //generatedOtp = _generateOtp();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    controller.repeat();
  }

  // String _generateOtp() {
  //   // Generate a random 4-digit number
  //   final random = Random();
  //   return (1000 + random.nextInt(9000)).toString();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    // Lottie.asset('assets/animations/OTP_Verification.json',
                    //     repeat: true,
                    //     controller: controller,
                    //     frameRate: FrameRate(100),
                    //     height: MediaQuery.of(context).size.height * 0.30),
                    SizedBox(
                      height: 230,
                      width: 230,
                      child: Image.asset(
                        Images.logo,
                        fit: BoxFit.fill,
                      ),
                    ),

                    // const SizedBox(
                    //   height: 7,
                    // ),
                    const Text(
                      'Verify with OTP',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sent via SMS to 784XXXXXXX',
                      style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Form(
                          key: formkey,
                          child: Pinput(
                            length: 4,
                            controller: otpController,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme.copyDecorationWith(
                                border: Border.all(color: Colors.purple),
                                borderRadius: BorderRadius.circular(15)),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.green)),
                            ),
                            validator: (s) {
                              if (s == '2222') {
                                return null;
                              } else {
                                return 'OTP is incorrect';
                              }
                            },
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) {
                              if (pin == '2222') {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const AboutUsPage()));
                              }
                              //print(pin);
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //Verify OTP button --------
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.06,
                    //   width: MediaQuery.of(context).size.width * 0.80,
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         // side: BorderSide(color: Colors.black),
                    //         backgroundColor:
                    //             Theme.of(context).colorScheme.primary,
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10)),
                    //       ),
                    //       onPressed: () {
                    //         if (otpController == '2222') {
                    //           // Navigator.pushReplacement(
                    //           //     context,
                    //           //     MaterialPageRoute(
                    //           //         builder: (context) => const AboutUsPage()),
                    //           //         );
                    //         }
                    //       },
                    //       child: const Text(
                    //         'Verify the OTP',
                    //         style: TextStyle(color: Colors.black, fontSize: 15),
                    //       )),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Log in using  ",
                          ),
                          //Resend--------
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>  Sign(),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Having trouble logging in ? ",
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Get help",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 46,
    height: 66,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(2, 15, 27, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.withOpacity(0.6)),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
