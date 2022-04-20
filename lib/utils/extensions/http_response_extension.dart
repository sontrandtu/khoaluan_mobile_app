import 'package:retrofit/retrofit.dart';

extension HttpResponseExtension on HttpResponse {
  bool get isOK => response.statusCode == 200;
}

