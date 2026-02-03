import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/routes/routes_path.dart';
import 'package:wise_players/core/shared_pref/shared_pref.dart';
import 'package:wise_players/core/widgets/custom_button.dart';
import 'package:wise_players/core/widgets/custom_text.dart';
import 'package:wise_players/data/_api/api_services/end_points.dart';

import '../../../../core/utils/app_logo.dart';
import '../../../../core/utils/get_device_info.dart';
import '../../../../core/widgets/custom_textFormFiled.dart';
import '../../../../data/_api/api_services/api_services.dart';
import '../../../../data/_api/dio_client.dart';

class LoginWithMac extends StatefulWidget {
  String deviceKey;
  static const String routeName = AppRoutes.loginWithMac;
  LoginWithMac({super.key, required this.deviceKey});

  @override
  State<LoginWithMac> createState() => _LoginWithMacState();
}

class _LoginWithMacState extends State<LoginWithMac> {
  ApiService apiService = ApiService();

  TextEditingController macCtrl = TextEditingController();
  TextEditingController deviceKeyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDeviceInfo0();
  }

  getDeviceInfo0() async {
    final data = await SharedPref.getUserDeviceInfo();
    macCtrl.text = "Mac: ${data['mac']}";
    deviceKeyCtrl.text = "Device Key: ${widget.deviceKey}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            appLogo(),
            Column(
              children: [
                CText(
                  "To Continue, Using The App",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),

                CText(
                  "Activate your playlist",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 15),

                CustomTextFormFiled(
                  controller: macCtrl,
                  hintText: "Device Mac",
                  isEnabled: false,
                ),
                const SizedBox(height: 20),
                CustomTextFormFiled(
                  controller: deviceKeyCtrl,
                  isEnabled: false,

                  hintText: "Device key",
                ),
                const SizedBox(height: 15),
                // CText("Device Id: 45:45:td:47:Ab:c9"),
                // const SizedBox(height: 15),

                // CText("Device key: 485654"),
                // const SizedBox(height: 15),
              ],
            ),
            Spacer(),
            CustomButton(
              child: CText("Activate"),
              onPressed: () async {
                final data = await SharedPref.getUserDeviceInfo();
                final activate = await apiService.hitPostApi(
                  reqData: {
                    "deviceId": data['mac'],
                    "activationKey": widget.deviceKey,
                  },
                  endpoint: Endpoints.activateAccount,
                );
                if (activate.isSuccess) {
                  SharedPref.setUserDeviceStatus("ACTIVE");
                  Navigator.pop(context, true);
                } else {
                  Navigator.pop(context, true);
                  log("error for activation the api is ${activate.data}");
                }
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CustomButton(
            //       width: 150,
            //       child: CText("Cancel"),
            //       onPressed: () {
            //         log("Get device info called");
            //         getDeviceInfo0();
            //       },
            //       backgroundColor: AppColor.transparent,
            //       isBorderSide: true,
            //     ),
            //     SizedBox(width: 40),
            //     CustomButton(
            //       width: 150,
            //       child: CText("Ok"),
            //       onPressed: () {},
            //       isBorderSide: true,
            //       backgroundColor: AppColor.transparent,
            //     ),
            //   ],
            // ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
