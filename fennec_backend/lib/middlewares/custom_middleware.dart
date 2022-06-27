import 'package:fennec/fennec.dart';
import 'package:fennec_jwt/fennec_jwt.dart';

import '../controllers/auth_controller.dart';

class CustomMiddleware extends MiddlwareHandler {
  const CustomMiddleware();
  @Middleware()
  Future<MiddleWareResponse> validateToken(
      Request request, Response response) async {
    final String token = request.body['token'];
    try {
      JwtClaim jwtClaim = validateJwt(token);
      if (request.additionalData == null) {
        request.additionalData = {'email': jwtClaim.toJson()['email']};
        request.additionalData = {'userId': jwtClaim.toJson()['userId']};
      } else {
        request.additionalData!.addAll({
          'email': jwtClaim.toJson()['email'],
          'userId': jwtClaim.toJson()['userId']
        });
      }
      return MiddleWareResponse(MiddleWareResponseEnum.next);
    } catch (e) {
      response.forbidden().json({'message': e.toString()});
      return MiddleWareResponse(MiddleWareResponseEnum.stop);
    }
  }

  JwtClaim validateJwt(String token) {
    final claimSet = verifyJwtHS256Signature(token, sharedSecret);
    claimSet.validate(issuer: 'fennec_jwt');
    return claimSet;
  }
}
