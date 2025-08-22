import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/common/helper/my_snack_bar.dart';
import 'package:crm/controller/customer.main.controller.dart';
import 'package:crm/data/model/additional_address.model.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/address_form/controllers/address_form.controller.dart';
import 'package:crm/presentation/customer/controllers/customer.controller.dart';
import 'package:crm/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomerDetailController extends GetxController {
  CustomerMainController ctrCustomerMain = Get.put(CustomerMainController());
  CustomerController ctrCustomer = Get.put(CustomerController());
  Rx<CustomerModel> item = Rx(Get.arguments);

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

  void onPressMore() {
    customModalBottom(Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final dynamic result = await Get.toNamed(Routes.CUSTOMER_FORM, arguments: item.value);
              if (result != null) {
                item.value = result;
                ctrCustomerMain.editData(result);
                ctrCustomer.getData();
                Get.back();
                MySnackBar.success(
                  Get.context!,
                  title: 'Customer successfully updated!',
                  subTitle: 'Customer information has been updated.',
                );
              }
            },
            child: Container(
              height: 34.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  SvgPicture.asset(ImageAssets.iconSvgEdit, width: 16.w),
                  SizedBox(width: 8.w),
                  Text('Edit', style: BaseText.grayDarkest.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400)),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    ));
  }

  void onClickEditAddress(AdditionalAddressModel v) async {
    Get.back();
    Get.delete<AddressFormController>();
    final ctrForm = Get.put(AddressFormController());
    ctrForm.initial(v: v, titleValue: 'Edit Additional Address');
    final AdditionalAddressModel? result = await customModalBottom<AdditionalAddressModel?>(AddressFormScreen());
    if (result != null) {
      final List<AdditionalAddressModel> existingAddress = [...item.value.additionalAddress];
      final index = existingAddress.indexWhere((e) => e.id == result.id);
      if (index >= 0) {
        existingAddress[index] = result;
        item.value = item.value.copyWith(additionalAddress: existingAddress);
        ctrCustomerMain.editData(item.value);
        ctrCustomer.getData();
        MySnackBar.success(
          Get.context!,
          title: 'Address successfully updated!',
          subTitle: 'Address has been updated.',
        );
      }
    }
  }

  void onClickAddAddress() async {
    Get.delete<AddressFormController>();
    final ctrForm = Get.put(AddressFormController());
    ctrForm.initial(titleValue: 'Add Additional Address');
    final AdditionalAddressModel? result = await customModalBottom<AdditionalAddressModel?>(AddressFormScreen());
    if (result != null) {
      final List<AdditionalAddressModel> addAddress = [result, ...item.value.additionalAddress];
      item.value = item.value.copyWith(additionalAddress: addAddress);
      ctrCustomerMain.editData(item.value);
      ctrCustomer.getData();
      MySnackBar.success(
        Get.context!,
        title: 'Address successfully added!',
        subTitle: 'New address added to your list.',
      );
    }
  }
}
