// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:hive/hive.dart';
// part 'contacts_local_model.g.dart';

// @HiveType(typeId: 0) // unique id
// class ContactsLocalModel extends HiveObject {
//   @HiveField(0)
//   String name;

//   @HiveField(1)
//   String phone;

//   @HiveField(2)
//   String? profileUrl;

//   ContactsLocalModel({
//     required this.name,
//     required this.phone,
//     this.profileUrl,
//   });
//   factory ContactsLocalModel.fromContact(Contact c) {
//     return ContactsLocalModel(
//       name: c.displayName,
//       phone: c.phones.first.number.isNotEmpty ? c.phones.first.number : '',
//       profileUrl: "",
//     );
//   }
// }
