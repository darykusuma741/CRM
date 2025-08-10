import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/presentation/document_activities/component/document_activities.detail.component.dart';
import 'package:get/get.dart';

class DocumentActivitiesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onClickDetail() {
    customModalBottom(DocumentActivitiesDetailComponent());
  }
}
