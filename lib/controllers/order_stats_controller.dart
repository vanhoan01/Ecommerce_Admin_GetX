import 'package:ecommerce_admin_getx/models/models.dart';
import 'package:ecommerce_admin_getx/services/database_service.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController {
  final DatabaseService database = DatabaseService();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    stats.value = database.getOrderStats();
    super.onInit();
  }
}
