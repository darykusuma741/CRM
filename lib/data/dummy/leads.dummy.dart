import 'dart:math';

import 'package:crm/data/model/leads.model.dart';

class LeadsDummy {
  static List<LeadsModel> data = [
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Acadia College Furniture Abadi",
      email: "melinaputriw@scaleocean.com",
      noHp: "083615263123",
      rating: 3,
      type: LeadsType.prospects,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Furnitures for New Location",
      email: "putrapratama@scaleocean.com",
      noHp: "083615263123",
      rating: 2,
      type: LeadsType.prospects,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Club Office Furnitures",
      email: "jasminealayacintya@clubfurnitures.com",
      noHp: "083615263123",
      rating: 1,
      type: LeadsType.lost,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Furnitures for New Location",
      email: "digitalutama@acadia.com",
      noHp: "083615263123",
      rating: 3,
      type: LeadsType.prospects,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Office Chairs",
      email: "haloadmin@scaleocean.com",
      noHp: "083615263123",
      rating: 2,
      type: LeadsType.lost,
    ),
  ];
}
