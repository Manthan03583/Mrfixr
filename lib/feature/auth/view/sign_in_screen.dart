import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/feature/auth/view/otp_screen.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/auth/widgets/social_login_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  final String fromPage;
  const SignInScreen(
      {Key? key, required this.exitFromApp, required this.fromPage})
      : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  bool _canExit = GetPlatform.isWeb ? true : false;

  final GlobalKey<FormState> customerSignInKey = GlobalKey<FormState>();

  @override
  void dispose() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.dispose();
  }

  @override
  void initState() {
    requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().fetchUserNamePassword();
      Get.find<AuthController>().initCountryCode();
    });
    super.initState();
  }

  requestFocus() async {
    Timer(const Duration(seconds: 1), () {
      if (!ResponsiveHelper.isWeb(context)) {
        _phoneFocus.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: const TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            ));
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: ResponsiveHelper.isDesktop(context)
              ? const WebMenuBar()
              : !widget.exitFromApp
                  ? AppBar(elevation: 0, backgroundColor: Colors.transparent)
                  : null,
          endDrawer:
              ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,
          body: SafeArea(
              child: FooterBaseView(
            isCenter: true,
            child: WebShadowWrap(
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: GetBuilder<AuthController>(builder: (authController) {
                    return Form(
                      autovalidateMode: ResponsiveHelper.isDesktop(context)
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      key: customerSignInKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.isDesktop(context)
                                ? Dimensions.webMaxWidth / 6
                                : ResponsiveHelper.isTab(context)
                                    ? Dimensions.webMaxWidth / 8
                                    : 0),
                        child: Column(children: [
                          Image.asset(
                            Images.logo,
                            width: Dimensions.logoSize,
                          ),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraMoreLarge),
                          // Mobile number input field
                          //------------------------
                          CustomTextField(
                            title: 'email_phone'.tr,
                            inputType: TextInputType.text,
                            hintText: 'enter_email_or_phone'.tr,
                            // hintText: 'Enter a phone number',
                            controller: authController.signInPhoneController,
                            focusNode: _phoneFocus,
                            nextFocus: _passwordFocus,
                            capitalization: TextCapitalization.words,
                            onCountryChanged: (countryCode) =>
                                authController.countryDialCodeForSignIn =
                                    countryCode.dialCode!,
                            onValidate: (String? value) {
                              return (GetUtils.isPhoneNumber(value!.tr) ||
                                      GetUtils.isEmail(value.tr))
                                  ? null
                                  : 'enter_email_or_phone'.tr;
                            },
                            // onValidate: (value) {
                            //   final phone = value.toString();
                            //   if (value == null || phone.trim().isEmpty) {
                            //     return 'Please enter your phone number';
                            //   }

                            //   final cleanedPhoneNumber =
                            //       phone.replaceAll(' ', '');

                            //   if (!RegExp(r'^[6789]\d{9}$')
                            //       .hasMatch(cleanedPhoneNumber)) {
                            //     return 'Please enter a valid 10-digit phone number';
                            //   } else if (cleanedPhoneNumber.length == 10) {
                            //     SystemChannels.textInput
                            //         .invokeMethod('TextInput.hide');
                            //   }

                            //   return null;
                            // },
                          ),
                          //--------------------INTL PACKAGE FOR NUMBER INPUT -------------------------------------------
                          // IntlPhoneField(
                          //   controller: authController.signInPhoneController,
                          //   initialCountryCode: 'IN',
                          //   dropdownTextStyle: const TextStyle(fontSize: 17),
                          //   dropdownIconPosition: IconPosition.trailing,
                          //   keyboardType: TextInputType.number,
                          //   style: const TextStyle(fontSize: 18),
                          //   decoration: const InputDecoration(
                          //       hintText: 'Enter a phone number'),
                          //   validator: (value) {
                          //     final phone = value.toString();
                          //     if (value == null || phone.trim().isEmpty) {
                          //       return 'Please enter your phone number';
                          //     }

                          //     final cleanedPhoneNumber =
                          //         phone.replaceAll(' ', '');

                          //     if (!RegExp(r'^[6789]\d{9}$')
                          //         .hasMatch(cleanedPhoneNumber)) {
                          //       return 'Please enter a valid 10-digit phone number';
                          //     } else if (cleanedPhoneNumber.length == 10) {
                          //       SystemChannels.textInput
                          //           .invokeMethod('TextInput.hide');
                          //     }

                          //     return null;
                          //   },
                          // ),
                          //----------------------------------------------------------------------

                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          CustomTextField(
                            title: 'password'.tr,
                            hintText: '************'.tr,
                            controller: authController.signInPasswordController,
                            focusNode: _passwordFocus,
                            inputType: TextInputType.visiblePassword,
                            isPassword: true,
                            inputAction: TextInputAction.done,
                            onValidate: (String? value) {
                              return FormValidation()
                                  .isValidPassword(value!.tr);
                            },
                          ),
                          //-------------------- [] REMEMBER ME ? ---------------------------------------
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: ListTile(
                          //         onTap: () =>
                          //             authController.toggleRememberMe(),
                          //         title: Row(
                          //           children: [
                          //             SizedBox(
                          //               width: 20.0,
                          //               child: Checkbox(
                          //                 activeColor:
                          //                     Theme.of(context).primaryColor,
                          //                 value:
                          //                     authController.isActiveRememberMe,
                          //                 onChanged: (bool? isChecked) =>
                          //                     authController.toggleRememberMe(),
                          //               ),
                          //             ),
                          //             const SizedBox(
                          //               width: Dimensions.paddingSizeExtraSmall,
                          //             ),
                          //             Text(
                          //               'remember_me'.tr,
                          //               style: ubuntuRegular.copyWith(
                          //                   fontSize: Dimensions.fontSizeSmall),
                          //             ),
                          //           ],
                          //         ),
                          //         contentPadding: EdgeInsets.zero,
                          //         dense: true,
                          //         horizontalTitleGap: 0,
                          //       ),
                          //     ),
                          //-------------------FORGET PASSWORD ---------------------------------------
                          //     Align(
                          //       alignment: Alignment.centerRight,
                          //       child: TextButton(
                          //         onPressed: () => Get.toNamed(
                          //             RouteHelper.getSendOtpScreen(
                          //                 "forget-password")),
                          //         child: Text('forgot_password'.tr,
                          //             style: ubuntuRegular.copyWith(
                          //               fontSize: Dimensions.fontSizeSmall,
                          //               color: Theme.of(context)
                          //                   .colorScheme
                          //                   .tertiary,
                          //             )),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          //------------------------------------------------------------------
                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          !authController.isLoading!
                              ? CustomButton(
                                  buttonText: 'sign_in'.tr,
                                  // buttonText: 'Send OTP',
                                  onPressed: () {
                                    if (customerSignInKey.currentState!
                                        .validate()) {
                                      _login(authController);
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CustomLoader(),
                                        ));
                                  },
                                )
                              : const CustomLoader(),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Get.find<SplashController>()
                                          .configModel
                                          .content
                                          ?.googleSocialLogin
                                          .toString() ==
                                      '1' ||
                                  Get.find<SplashController>()
                                          .configModel
                                          .content
                                          ?.facebookSocialLogin
                                          .toString() ==
                                      '1'
                              ? SocialLoginWidget(
                                  fromPage: widget.fromPage,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${'do_not_have_an_account'.tr} ',
                                style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  authController.signInPhoneController.clear();
                                  authController.signInPasswordController
                                      .clear();

                                  Get.toNamed(RouteHelper.getSignUpRoute());
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text('sign_up_here'.tr,
                                    style: ubuntuRegular.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: Dimensions.fontSizeSmall,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'continue_as'.tr,
                                style: ubuntuMedium.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.6)),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Get.find<CartController>().getCartData();
                                  Get.offNamed(
                                      RouteHelper.getMainRoute('home'));
                                },
                                child: Text(
                                  'guest'.tr,
                                  style: ubuntuMedium.copyWith(
                                      color: Colors.blue.shade700),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraMoreLarge,
                          ),
                        ]),
                      ),
                    );
                  }),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }

  void _login(AuthController authController) async {
    authController.login(widget.fromPage);
  }
}
