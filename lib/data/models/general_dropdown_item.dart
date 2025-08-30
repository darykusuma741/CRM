class GeneralDropdownItem {
  int id;
  String name;

  GeneralDropdownItem({
    required this.id,
    required this.name,
  });
}

List<GeneralDropdownItem> customerPipelines = [
  GeneralDropdownItem(
    id: 1,
    name: "PT Jaya Bangunan",
  ),
  GeneralDropdownItem(
    id: 2,
    name: "PT Setia Abadi",
  ),
  GeneralDropdownItem(
    id: 3,
    name: "PT Jaya Teknologi",
  ),
  GeneralDropdownItem(
    id: 4,
    name: "PT Sinar Mas Cemara Indonesia",
  ),
  GeneralDropdownItem(
    id: 5,
    name: "PT Bangun Makna",
  ),
  GeneralDropdownItem(id: 6, name: "PT Abadi Jaya"),
  GeneralDropdownItem(id: 7, name: "PT Aktif Digital"),
];

List<String> customerPipelines2 = [
  "PT Jaya Bangunan",
  "PT Setia Abadi",
  "PT Jaya Teknologi",
  "PT Sinar Mas Cemara Indonesia",
  "PT Bangun Makna",
  "PT Abadi Jaya",
  "PT Aktif Digital",
];
