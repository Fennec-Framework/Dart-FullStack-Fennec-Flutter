import 'package:fennec_pg/fennec_pg.dart';

@Table('users')
class User extends Serializable {
  @PrimaryKey(autoIncrement: true)
  int? id;
  @Column(
      indexType: IndexType.unique, type: ColumnType.varChar, isNullable: false)
  late String email;
  @Column(
      indexType: IndexType.unique,
      type: ColumnType.varChar,
      isNullable: false,
      alias: 'user_name')
  late String userName;
  @Column(type: ColumnType.varChar, isNullable: false)
  late String password;
  User.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    userName = map['user_name'];
    password = map['password'];
  }
  User();
}
