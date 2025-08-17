import 'dart:math';

import 'package:crm/data/model/leads.model.dart';

class LeadsDummy {
  static List<LeadsModel> data = [
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Acadia College Furniture Abadi",
      name: "Ms. Melina Putri",
      email: "melinaputriw@scaleocean.com",
      noHp: "083615263123",
      rating: 3,
      jobPosition: 'UI/UX Designer',
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28,Grogol Petamburan Kec. Menteng, Jakarta Barat",
      type: LeadsType.prospects,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Furnitures for New Location",
      name: "Ms. Melina Putri",
      email: "putrapratama@scaleocean.com",
      noHp: "083615263123",
      rating: 2,
      jobPosition: 'UI/UX Designer',
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28,Grogol Petamburan Kec. Menteng, Jakarta Barat",
      type: LeadsType.prospects,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Club Office Furnitures",
      name: "Ms. Melina Putri",
      email: "jasminealayacintya@clubfurnitures.com",
      noHp: "083615263123",
      rating: 1,
      jobPosition: 'UI/UX Designer',
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28,Grogol Petamburan Kec. Menteng, Jakarta Barat",
      type: LeadsType.lost,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Furnitures for New Location",
      name: "Ms. Melina Putri",
      email: "digitalutama@acadia.com",
      noHp: "083615263123",
      rating: 3,
      jobPosition: 'UI/UX Designer',
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28,Grogol Petamburan Kec. Menteng, Jakarta Barat",
      type: LeadsType.prospects,
    ),
    LeadsModel(
      id: Random().nextInt(999999),
      title: "Office Chairs",
      name: "Ms. Melina Putri",
      email: "haloadmin@scaleocean.com",
      noHp: "083615263123",
      rating: 2,
      jobPosition: 'UI/UX Designer',
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28,Grogol Petamburan Kec. Menteng, Jakarta Barat",
      type: LeadsType.lost,
    ),
  ];
}
