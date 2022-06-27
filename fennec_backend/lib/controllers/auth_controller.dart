import 'dart:math';

import 'package:fennec/fennec.dart' hide UserRepository;
import 'package:fennec_jwt/fennec_jwt.dart';
import 'package:fennec_pg/fennec_pg.dart';

import '../middlewares/custom_middleware.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

final String sharedSecret = '123456';

@RestController(path: '/auth')
class AuthController {
  UserRepository userRepository = UserRepository();
  @Route('/signup', RequestMethod.post())
  Future signUp(Request request, Response response) async {
    User user = User();
    user.email = request.body['email'];
    //you can save password crypted by using crypto plugin
    user.password = request.body['password'];
    user.userName = request.body['user_name'];
    final result = await userRepository.insert(user);
    if (result == null) {
      response.badRequest().json({'message': 'error by creating new User'});
    } else {
      response.ok().json({'user': result.toJson()});
    }
  }

  @Route('/signin', RequestMethod.post())
  Future signin(Request request, Response response) async {
    String email = request.body['email'];
    String password = request.body['password'];
    FilterBuilder filterBuilder = Equals('email', "'$email'");
    filterBuilder.and(Equals('password', "'$password'"));
    final result = await userRepository.findAll(filterBuilder: filterBuilder);
    if (result.isEmpty) {
      response.badRequest().json({'message': 'User not Found'});
    } else if (result.length > 1) {
      response.badRequest().json({'message': 'Many Users found'});
    } else {
      final claimSet = JwtClaim(
        issuer: 'fennec_jwt',
        subject: 'jwt',
        jwtId: generateRandomString(32),
        otherClaims: <String, dynamic>{
          'userId': result.first.id,
          'email': email
        },
        maxAge: const Duration(minutes: 5),
      );
      final token = generateJwtHS256(claimSet, sharedSecret);
      response.ok().json({'user': result.first.toJson(), 'token': token});
    }
  }

  @AuthenticatedRoute('/getProfile', RequestMethod.post(), CustomMiddleware())
  Future getCurrentProfile(Request request, Response response) async {
    int userId = request.additionalData!['userId'];
    final result = await userRepository.findOneById(userId);
    if (result == null) {
      response.badRequest().json({'message': 'User not Found by $userId'});
    } else {
      response.ok().json({'user': result.toJson()});
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
