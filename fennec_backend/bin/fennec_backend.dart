import 'package:fennec/fennec.dart';
import 'package:fennec_backend/controllers/auth_controller.dart';
import 'package:fennec_pg/fennec_pg.dart';

Future<void> main(List<String> arguments) async {
  print('Hello world!');
  var uri = 'postgres://user:password@localhost:5432/db_name';
  await PGConnectionAdapter.init(uri);
  Application application = Application('0.0.0.0', 8080);
  application.addController(AuthController);
  Server server = Server(application);
  await server.startServer();
}
