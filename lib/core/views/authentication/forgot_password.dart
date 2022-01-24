import 'package:sologwarehouseapp/core/controllers/authentication/forgot_password_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: forgotPasswordController,
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
            actionBackButton: () {
              Get.back();
            },
            actionButton: [],
            title: "",
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 20.0, left: 20.0, bottom: 40),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            'Reset Password?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Text(
                            'Masukkan email yang digunakan mendaftar akun Fleetsumo dan kami akan mengirimkan instruksi untuk mereset password',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 0.0, right: 20.0, left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0),
                            ),
                            Container(
                                transform:
                                    Matrix4.translationValues(0.0, -8.0, 0.0),
                                child: Theme(
                                    child: TextFormField(
                                      controller: forgotPasswordController
                                          .usernameController,
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      cursorColor: ColorApp.mainColorApp,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        focusedBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: "Email disini...",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    data: Theme.of(context).copyWith(
                                      primaryColor: ColorApp.mainColorApp,
                                    ))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: AppButton().mainButton(
                          textButton: "Kirim Reset Password",
                          function: () {
                            forgotPasswordController.validation();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
