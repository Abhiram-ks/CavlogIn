
import 'package:admin/core/utils/const/constent.dart';


class CloudinaryConfig {
  static late String cloudName;
  static late String apiKey;
  static late String apiSecret;

  static void initialize() {
      cloudName = EnvConstants.cloudinaryCloudName;
      apiKey = EnvConstants.cloudinaryApiKey;
      apiSecret = EnvConstants.cloudinaryApiSecret; 
    

    if (cloudName.isEmpty || apiKey.isEmpty || apiSecret.isEmpty) {
      throw Exception("Cloudinary credentials are missing.");
    }
  }
}
