
import 'package:hive/hive.dart';
// part 'user.g.dart';
@HiveType(typeId: 1)
class User {
  User({required this.name,required this.email});
  @HiveField(0)
   String name;

  @HiveField(1)
   String email;

}