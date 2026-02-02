import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/routes/routes_path.dart';
import 'package:wise_players/core/utils/app_logo.dart';
import 'package:wise_players/core/utils/loader.dart';
import 'package:wise_players/core/widgets/custom_button.dart';
import 'package:wise_players/core/widgets/custom_text.dart';
import 'package:wise_players/data/_api/api_services/end_points.dart';
import 'package:wise_players/presentation/screen_view/common/auth/login_with_mac.dart';
import 'package:wise_players/presentation/screen_view/common/content_option_tv/content_option_tv.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/utils/exit_dialog.dart';
import '../../../../core/utils/get_device_info.dart';
import '../../../../core/utils/get_dymention.dart';
import '../../../../data/_api/api_services/api_services.dart';

class FetchPhoneInfoMac extends StatefulWidget {
  static String routeName = AppRoutes.fetchPhoneInfoMac;

  const FetchPhoneInfoMac({super.key});

  @override
  State<FetchPhoneInfoMac> createState() => _FetchPhoneInfoMacState();
}

class _FetchPhoneInfoMacState extends State<FetchPhoneInfoMac> {
  ApiService apiService = ApiService();
  String deviceMac = "";
  String deviceKey = "";
  bool isStatusActive = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await getDeviceInfo0();
    await checkUserStatus();
  }

  checkUserStatus() async {
    log("the response of isStatusActive is $isStatusActive");
    isStatusActive = await SharedPref.getUserDeviceStatus();
    if (!isStatusActive) {
      log("the response of isStatusActive is $isStatusActive");
      final userDeviceInfo = await getDeviceInfo();
      log("1");
      final userData = await apiService.hitPostApi(
        reqData: {'fingerprint': userDeviceInfo['macLikeId']},
        endpoint: Endpoints.checkDeviceStatus,
      );
      log("2");
      final getDeviceKey = await apiService.hitPostApi(
        reqData: {'deviceId': userDeviceInfo['macLikeId']},
        endpoint: Endpoints.generateDeviceKeyEndpoint,
      );
      log("3");
      if (userData.isSuccess && getDeviceKey.isSuccess) {
        SharedPref.setValidateStatus(
          deviceId: userData.data?['deviceId'] ?? "",
          status: userData.data?['status'] ?? "",
          token: userData.data?['token'] ?? "",
        );
        deviceKey = getDeviceKey.data?['activationKey'];
      } else {
        log("Failed to fetch user status: ${userData.error}");
      }
    } else {
      isStatusActive = await SharedPref.getUserDeviceStatus();
      final data = await SharedPref.getUserDeviceInfo();
      deviceMac = data['mac'] ?? "Not found";
      deviceKey = data['deviceKey'] ?? "Not found";
    }
    setState(() {});
  }

  getDeviceInfo0() async {
    isStatusActive = await SharedPref.getUserDeviceStatus();
    if (!isStatusActive) {
      final userDeviceInfo = await getDeviceInfo();
      final res = await apiService.hitPostApi(
        reqData: {
          "deviceId": userDeviceInfo['macLikeId'] ?? "",
          "deviceModel": userDeviceInfo['model'] ?? "",
          "osVersion": userDeviceInfo['androidVersion'] ?? "",
          "platform": "ANDROID",
        },
        endpoint: Endpoints.deviceRegister,
      );

      if (res.isSuccess) {
        SharedPref.setUserDeviceInfo(
          macAddress: userDeviceInfo['macLikeId'] ?? "",
          deviceId: "",
          status: "",
          token: "",
        );
        deviceMac = userDeviceInfo['macLikeId'] ?? "";
      } else {
        log("Login with mac failed: ${res.error} or ");
      }
      setState(() {});
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    S s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: null,
        title: appLogo(),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: mHeight < 700
              ? SingleChildScrollView(child: buildBodyContent(s))
              : buildBodyContent(s),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CText(
                  '${s.macLabel}: $deviceMac',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 5),
                CText(
                  s.tvOnlyWarning,
                  fontSize: 14,
                  color: AppColor.darkRed,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBodyContent(S s) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Image.asset("assets/images/Group.png", height: 120, width: 200),
        SizedBox(height: 20),
        CText(s.macNotAssociated, fontSize: 20),
        SizedBox(height: 30),
        Wrap(
          children: [
            Opacity(
              opacity: isStatusActive ? 1 : 0.3,
              child: CustomButton(
                backgroundColor: AppColor.darkBlue,
                width: 150,
                child: CText(s.uploadPlaylist),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContentOption()));
                  if (isStatusActive) {
                  } else {
                    return;
                  }
                },
              ),
            ),
            const SizedBox(width: 20, height: 60),
            CustomButton(
              backgroundColor: AppColor.darkBlue,
              width: 100,
              child: CText(s.refresh),
              onPressed: () {
                loader(context);
                Future.delayed(Duration(seconds: 1), () async {
                  await checkUserStatus();
                  stopLoader(context);
                });
                // checkUserStatus();
                // stopLoader(context);
              },
            ),
            const SizedBox(width: 20, height: 60),
            CustomButton(
              backgroundColor: AppColor.darkBlue,
              width: 150,
              child: CText(s.language),

              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
              },
            ),
            const SizedBox(width: 20, height: 60),
            CustomButton(
              backgroundColor: AppColor.darkBlue,
              width: 80,
              child: Icon(Icons.power_settings_new, color: AppColor.white),
              onPressed: () {
                showExitDialog(context, s);
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        !isStatusActive
            ? CText(
                s.playerNotActive,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              )
            : SizedBox.shrink(),
        !isStatusActive ? const SizedBox(height: 30) : SizedBox.shrink(),
        !isStatusActive
            ? CustomButton(
                width: 160,
                child: CText(s.activateNow),
                onPressed: () {
                  GoRouter.of(
                    context,
                  ).push(LoginWithMac.routeName, extra: deviceKey);
                },
              )
            : Container(
                color: AppColor.white,
                padding: EdgeInsets.all(5),
                child: QrImageView(
                  data:
                      'https://thumbs.dreamstime.com/b/romantic-i-love-you-card-hearts-white-background-express-your-love-card-romantic-i-love-you-card-hearts-301723680.jpg',
                  version: QrVersions.auto,
                  size: 180,
                ),
              ),
        const SizedBox(height: 20),
      ],
    );
  }
}
