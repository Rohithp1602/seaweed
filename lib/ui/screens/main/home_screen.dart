import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seaweed/models/commen_model.dart';
import 'package:seaweed/theme/app_assets.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/screens/main/map_screen/google_map_controller.dart';
import 'package:seaweed/ui/widgets/app_progress_view.dart';
import 'package:seaweed/utils/extension.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GoogleMapScreenController googleMapScreenController =
      Get.find<GoogleMapScreenController>();

  @override
  Widget build(BuildContext context) {
    googleMapScreenController.getPostData();
    return Scaffold(
      backgroundColor: appGrayBgColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: appWhite,
        toolbarHeight: 80,
        title: Image.asset(
          ImageIcons.ic_app,
          height: 70,
          width: 70,
        ),
      ),
      body: GetBuilder<GoogleMapScreenController>(initState: (ctrlState) {
        internetCheck();
      }, builder: (ctrl) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: homeMenuList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          homeMenuList[index].onTap();
                        },
                        child: Container(
                          height: Get.height * 0.1,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              (20.0).addWSpace(),
                              Image.asset(
                                homeMenuList[index].icText,
                                height: Get.height / 10,
                                width: Get.width / 10,
                              ),
                              (20.0).addWSpace(),
                              Expanded(
                                child: Text(
                                  homeMenuList[index].text,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  style: appTextStyleSifonFont(
                                      color: appWhite,
                                      fontSize: Get.height * 0.022,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ).paddingOnly(left: 30, right: 30, bottom: 17, top: 17),
                      );
                    },
                  ),
                )
              ],
            ),
            Obx(() => googleMapScreenController.isLoading.value
                ? const AppProgress()
                : Container()),
          ],
        );
      }),
    );
  }

  internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      googleMapScreenController.getPostData();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      googleMapScreenController.getPostData();
    } else {
      showAppSnackBar("No internet connection");
    }
  }
}
