import 'package:flutter/material.dart';
import 'package:demo_flutter/common/models/logoutlist.dart';
import 'package:demo_flutter/common/values/values.dart';
import 'package:get/get.dart';
import './index.dart';
import '../../common/utils/utils.dart';
import 'package:flutter/services.dart';

class LogoutOperationController extends GetxController {
  final state = LogoutOperatState();
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    initData();
    print("qwqwqwqwq");
  }

  void initData() async {
    // Map<String, dynamic> map =
    //     await HttpUtil().post(SERVER_API_URL + LOGOUT_CHECK);
    // LogoutList list = LogoutList.fromJson(map);
    // state.logoutList.value = list.result?.forbidCancelReasons ?? [];
    state.sec.value = "🙄";
    List<ForbidCancelReason> mockList = List.generate(
        20,
        (int index) => ForbidCancelReason(
              opNameDesc: '$index + ASD',
              checkResult: index.isEven ? true : false,
              reasonDesc: "去操作咯",
            ));
    state.logoutList.value = mockList;
  }

  void logout() {
    AlertUtil.showAlert("嗨", state.sec.value,
        leftButtonTap: () => Get.back(), rightButtonTap: () => Get.back());
  }

  Future<void> refresh() async {
    // state.logoutList.clear();
    List<ForbidCancelReason> mockList = List.generate(
        20,
        (int index) => ForbidCancelReason(
              opNameDesc: '$index + ASD',
              checkResult: index.isEven ? true : false,
              reasonDesc: "去操作咯",
            ));
    state.logoutList.addAll(mockList);
    print('list个数：${state.logoutList.length}');
    update(['list']);
  }

  void handleItemTap(int index) {
    ForbidCancelReason reason = state.logoutList[index];
    const methodChannel =
        const MethodChannel('com.methodChannelName.iOSFlutter');
    methodChannel.invokeMethod('aaa', reason.opNameDesc);
  }
}
