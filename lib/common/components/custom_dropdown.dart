import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/common/components/custom_error_text.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:flutter_svg/svg.dart';

// Widget dropdown custom yang mendukung generic data type T
class CustomDropdown<T> extends StatefulWidget {
  final List<T> items; // Daftar item untuk ditampilkan dalam dropdown
  final T? selectedItem; // Item yang sedang dipilih
  final String Function(T?)? customContent; // Builder custom untuk tampilkan item
  final String? label; // Label input di atas dropdown
  final String? error; // Pesan error validasi
  final bool showScroll; // Flag (belum digunakan)
  final String? iconLeftAsset; // Ikon di sisi kiri input
  final void Function(T value)? onChanged; // Callback ketika item dipilih

  const CustomDropdown({
    super.key,
    required this.items,
    this.error,
    this.selectedItem,
    this.label,
    this.iconLeftAsset,
    this.onChanged,
    this.customContent,
    this.showScroll = false,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink(); // Untuk koneksi CompositedTransformTarget & Follower
  OverlayEntry? _overlayEntry; // Menyimpan dropdown overlay

  late AnimationController _arrowAnimationController; // Controller untuk animasi panah
  late Animation<double> _arrowAnimation; // Animasi rotasi panah

  late AnimationController _dropdownAnimationController; // Controller untuk animasi dropdown
  late Animation<Offset> _slideAnimation; // Animasi geser dropdown
  late Animation<double> _fadeAnimation; // Animasi fade dropdown

  bool isDropdownOpen = false; // Flag status dropdown terbuka

  @override
  void initState() {
    super.initState();

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(_arrowAnimationController);

    _dropdownAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.05), // Dropdown turun sedikit dari atas
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _dropdownAnimationController, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _dropdownAnimationController, curve: Curves.easeOut),
    );
  }

  // Fungsi toggle dropdown (tutup jika buka, buka jika tutup)
  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showDropdown();
    } else {
      _removeDropdown();
    }
  }

  // Tampilkan dropdown dalam overlay
  void _showDropdown() {
    setState(() {
      isDropdownOpen = true;
    });

    _arrowAnimationController.forward(); // Putar panah ke bawah

    final overlay = Overlay.of(context); // Ambil overlay
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero); // Posisi widget
    final size = renderBox.size; // Ukuran widget

    final overlayHeight = MediaQuery.of(context).size.height;
    final dropdownMaxHeight = 216.h;

    // Cek apakah dropdown cukup ditampilkan di bawah
    final canShowBelow = position.dy + size.height + dropdownMaxHeight <= overlayHeight;

    // Buat entry overlay
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Layer untuk mendeteksi klik di luar dropdown
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (widget.selectedItem == null && widget.items.isNotEmpty) {
                  widget.onChanged?.call(widget.items[0]);
                }
                _removeDropdown();
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          // Dropdown follower
          Positioned(
            width: size.width,
            left: position.dx,
            top: canShowBelow ? position.dy + size.height : null,
            bottom: canShowBelow ? null : overlayHeight - position.dy,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, canShowBelow ? size.height : (-dropdownMaxHeight + 48.0)),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Material(
                    elevation: 4,
                    color: ColorsName.white,
                    shadowColor: const Color(0x33333A51),
                    borderRadius: BorderRadius.circular(6.r),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: dropdownMaxHeight),
                      child: ListView.builder(
                        itemCount: widget.items.length,
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          Color colorSelect = widget.selectedItem == item ? ColorsName.blueDew : ColorsName.white;
                          if (widget.selectedItem == null && index == 0) {
                            colorSelect = ColorsName.blueDew;
                          }

                          return GestureDetector(
                            onTap: () {
                              widget.onChanged?.call(item);
                              _removeDropdown();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: colorSelect,
                              ),
                              child: Text(
                                widget.customContent == null ? item.toString() : widget.customContent!(item),
                                style: BaseText.grayDarker.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

    _dropdownAnimationController.forward(); // Jalankan animasi masuk
    overlay.insert(_overlayEntry!); // Masukkan ke overlay
  }

  // Fungsi untuk menutup dropdown
  void _removeDropdown({bool fromDispose = false}) {
    if (!fromDispose) {
      setState(() {
        isDropdownOpen = false;
      });
    }

    _arrowAnimationController.reverse(); // Kembalikan panah ke atas
    _dropdownAnimationController.reverse().then((_) {
      _overlayEntry?.remove(); // Hapus overlay dari tree
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Style teks
    final styleText = BaseText.grayDarker.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
    final styleTextHint = BaseText.grayMedium.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
    final labelStyle = BaseText.blueMuted.copyWith(fontSize: 12.sp);
    final requiredStyle = BaseText.redCherry.copyWith(fontSize: 12.sp);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Row(
              children: [
                Text(widget.label!, style: labelStyle),
                Text(' *', style: requiredStyle), // Tanda wajib isi
              ],
            ),
          if (widget.label != null) SizedBox(height: 5.h),

          // Input field
          GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.error == null ? (isDropdownOpen ? ColorsName.blueSteel : ColorsName.grayPearly) : ColorsName.redTomato,
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 13.75.w),
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.iconLeftAsset != null) Image.asset(widget.iconLeftAsset!, height: 11.67.h),
                        SizedBox(width: widget.iconLeftAsset != null ? 8.w : 0),
                        Expanded(
                          child: Text(
                            widget.customContent == null ? widget.selectedItem?.toString() ?? 'Pilih item' : widget.customContent!(widget.selectedItem),
                            style: widget.selectedItem != null ? styleText : styleTextHint,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  RotationTransition(
                    turns: _arrowAnimation,
                    child: Center(child: SvgPicture.asset(ImageAssets.iconSvgChevronRight, height: 7.h)),
                  ),
                  SizedBox(width: 12.w),
                ],
              ),
            ),
          ),

          // Tampilkan error jika ada
          if (widget.error != null) CustomErrorText(error: widget.error),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _removeDropdown(fromDispose: true); // Pastikan overlay dibuang tanpa setState
    _arrowAnimationController.dispose(); // Dispose animasi
    _dropdownAnimationController.dispose();
    super.dispose();
  }
}
