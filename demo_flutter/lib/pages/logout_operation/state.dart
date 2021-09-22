import 'package:get/get.dart';
import '../../common/models/logoutlist.dart';

class LogoutOperatState {
  final _obj = "".obs;

  set obj(value) => this._obj.value = value;

  get obj => this._obj.value;

  RxList<ForbidCancelReason> logoutList = <ForbidCancelReason>[].obs;

  RxString sec = "".obs;
}
