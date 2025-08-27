import 'package:crm/data/dummy/pipeline.dummy.dart';
import 'package:crm/data/model/pipeline.model.dart';
import 'package:get/get.dart';

class PipelineMainController extends GetxController {
  final data = Rx<List<PipelineModel>>([]);

  Future getData() async {
    data.value = data.value.isEmpty ? PipelineDummy.data : data.value;
  }
}
