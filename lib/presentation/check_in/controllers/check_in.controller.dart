import 'dart:async';
import 'dart:io';

import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/common/google_service.dart';
import 'package:crm/common/helper/my_location.helper.dart';
import 'package:crm/common/helper/my_snack_bar.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CheckInController extends GetxController {
  Rxn<ActivityModel?> data = Rxn(Get.arguments);

  final Rx<Completer<GoogleMapController>> ctrGoogleMap = Rx(Completer<GoogleMapController>());
  final Rx<CameraPosition> initialCameraPosition = Rx(CameraPosition(
    target: LatLng(-6.174692567487111, 106.78966208650647),
    zoom: 15.4746,
  ));
  final Rx<Map<MarkerId, Marker>> markers = Rx(<MarkerId, Marker>{});
  final Rxn<LocationData?> myLocationData = Rxn();
  final CustomLoadingController ctrLoading = Get.find<CustomLoadingController>();
  RxBool isVisible = false.obs;
  final Rxn<String?> address = Rxn();
  final Rxn<File?> photo = Rxn();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(milliseconds: 500), () {
      isVisible.value = true;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    ctrGoogleMap.value.complete(controller);
    onTapGetMyLocation();
  }

  void onTapGetMyLocation() async {
    try {
      ctrLoading.isLoading.value = true;

      myLocationData.value = await MyLocationHelper.getMyLocation();

      if (myLocationData.value?.latitude == null || myLocationData.value?.longitude == null) throw 'No Location Data';

      addMarker(LatLng(myLocationData.value!.latitude!, myLocationData.value!.longitude!));
      address.value = await LocationService().getAddress(myLocationData.value!.latitude!, myLocationData.value!.longitude!);

      final GoogleMapController controller = await ctrGoogleMap.value.future;
      CameraPosition kLake = CameraPosition(
        target: LatLng(myLocationData.value!.latitude!, myLocationData.value!.longitude!),
        zoom: 16.8,
      );

      await controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
    } catch (e) {
      MySnackBar.error(Get.context!, title: e.toString());
    } finally {
      ctrLoading.isLoading.value = false;
    }
  }

  void addMarker(LatLng position) {
    final MarkerId markerId = MarkerId('My Location');
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      onTap: () {},
    );

    markers.update((e) {
      markers.value[markerId] = marker;
    });
  }

  void onTapBack() async {
    Get.back();
  }

  void onSubmit() async {
    Get.back();
    // if (myLocationData.value?.latitude == null || myLocationData.value?.longitude == null) {
    //   MySnackBar.error(Get.context!, title: "Lokasi tidak terdeteksi");
    //   return;
    // }
    // if (photo.value == null) {
    //   MySnackBar.error(Get.context!, title: "Photo wajib di isi");
    //   return;
    // }

    // ctrLoading.isLoading.value = true;
    // CheckInOutModel? result;
    // if (ctrCheckInMain.lastCheckInOut.value?.logTimeIn == null) {
    //   result = await ctrCheckInMain.checkInProcess(
    //     myLocationData.value!.latitude!,
    //     myLocationData.value!.longitude!,
    //     photo: photo.value!,
    //   );
    // } else {
    //   result = await ctrCheckInMain.checkOutProcess(
    //     myLocationData.value!.latitude!,
    //     myLocationData.value!.longitude!,
    //     photo: photo.value!,
    //   );
    // }
    // if (result != null) {
    //   Get.back();
    //   MySnackBar.success(Get.context!, title: "Sukses", subTitle: "selamat kamu berhasil absen");
    //   ctrLoading.isLoading.value = true;
    //   await ctrCheckInMain.getLastCheckIn();
    //   ctrLoading.isLoading.value = false;
    // }
    // ctrLoading.isLoading.value = false;
  }
}
