// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProfileMenuGroup {
  final int id;
  final String title;
  final List<ProfileMenu> profileMenuList;

  ProfileMenuGroup({
    required this.id,
    required this.title,
    required this.profileMenuList
  });
}

class ProfileMenu {
  final int id;
  final String title;
  final String iconAsset;

  ProfileMenu({
    required this.id,
    required this.title,
    required this.iconAsset,
  });
}

List<ProfileMenuGroup> profileMenuGroups = [
  ProfileMenuGroup(
    id: 1,
    title: "General",
    profileMenuList: [
      ProfileMenu(
        id: 0,
        title: "Customer",
        iconAsset: "" //const LocalImages().profileCustomerIcon
      ),
      ProfileMenu(
        id: 1,
        title: "Quotation",
        iconAsset: "" //const LocalImages().profileQuotationIcon
      ),
      ProfileMenu(
        id: 2,
        title: "Product",
        iconAsset: "" //const LocalImages().profileProductIcon
      ),
      ProfileMenu(
        id: 3,
        title: "Lost",
        iconAsset: "" //const LocalImages().profileLostIcon
      ),
      ProfileMenu(
        id: 4,
        title: "History Activity",
        iconAsset: "" //const LocalImages().profileHistoryIcon
      ),
    ]
  ),
  ProfileMenuGroup(
    id: 2,
    title: "Others",
    profileMenuList: [
      ProfileMenu(
        id: 6,
        title: "Log Out",
        iconAsset: "" //const LocalImages().profileLogOutIcon
      )
    ]
  ),
];
