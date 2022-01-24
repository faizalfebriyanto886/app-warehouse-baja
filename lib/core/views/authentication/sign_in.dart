import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sologwarehouseapp/core/controllers/authentication/sign_in_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/button.dart';

class SignIn extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 15,
              ),
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                    bottom: 40,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text('Selamat datang,',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        )),
                    subtitle: RichText(
                      text: TextSpan(children: <WidgetSpan>[
                        WidgetSpan(
                          child: Text(
                            "Login dengan akun ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            "Solog Warehouse App",
                            style: TextStyle(
                              color: ColorApp.mainColorApp,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Username",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                              child: TextFormField(
                                controller: controller.usernameController,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                cursorColor: ColorApp.mainColorApp,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                obscureText: false,
                                decoration: InputDecoration(
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    hintText: "Username disini...",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                              data: Theme.of(context).copyWith(
                                primaryColor: ColorApp.mainColorApp,
                              ))),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Katasandi",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                              child: TextFormField(
                                controller: controller.passwordController,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                cursorColor: ColorApp.mainColorApp,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                obscureText:
                                    controller.isPasswordVisible ? false : true,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.changeVisibilityPassword();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: controller.isPasswordVisible
                                              ? ColorApp.mainColorApp
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.transparent)),
                                    hintText: "Katasandi disini...",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                              data: Theme.of(context).copyWith(
                                primaryColor: ColorApp.mainColorApp,
                              ))),
                    ],
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   margin:
                //       const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
                //   child: InkWell(
                //     borderRadius: BorderRadius.circular(10),
                //     onTap: () {
                //       Get.to(() => ForgotPassword());
                //     },
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //       child: Text(
                //         "Lupa password?",
                //         style: TextStyle(
                //             color: ColorApp.mainColorApp,
                //             fontSize: 13,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: controller.isLoading
                      ? Column(
                          children: [
                            Container(
                              height: 60,
                              width: 30,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                              ),
                            ),
                          ],
                        )
                      : AppButton().mainButton(
                          textButton: "Login ke Solog WMS",
                          function: () {
                            controller.validation();
                          },
                        ),
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: const EdgeInsets.only(
                //     top: 25.0,
                //     right: 20.0,
                //     left: 20.0,
                //   ),
                //   child: Container(
                //     child: RichText(
                //       text: TextSpan(children: <WidgetSpan>[
                //         WidgetSpan(
                //           child: Text(
                //             "Visit us at",
                //             style: TextStyle(
                //               color: Colors.grey,
                //               fontWeight: FontWeight.normal,
                //               fontSize: 13,
                //             ),
                //           ),
                //         ),
                //         WidgetSpan(
                //           child: GestureDetector(
                //             onTap: () {},
                //             child: Text(
                //               " Fleetsumo.com",
                //               style: TextStyle(
                //                 color: ColorApp.mainColorApp,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 13,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ]),
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                //   child: AppButton().whiteButton(
                //     textButton: "Kunjungi fleetsumo.com",
                //     function: () {},
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
