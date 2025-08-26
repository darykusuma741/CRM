import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/presentation/pipeline/header/pipeline.header.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/pipeline.controller.dart';

class PipelineScreen extends GetView<PipelineController> {
  const PipelineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'My Pipeline',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PipelineHeader(),
          ],
        ),
      ),
    );
  }
}
