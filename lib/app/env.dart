// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  String get apiBaseUrl =>
      dotenv.env['STAGING_BASE_URL'] ?? '';

  String get stagingFlwPublicKey => dotenv.env['STAGING_FLW_PUBLIC_KEY'] ?? "";
  String get stagingFlwSecretKey => dotenv.env['STAGING_FLW_SECRET_KEY'] ?? "";
  String get stagingFlwEncryptionKey =>
      dotenv.env['STAGING_FLW_ENCRYPTION_KEY'] ?? "";
  String get isDebug => dotenv.env['STAGING_IS_DEBUG'] ?? "";

  String get prodApiBaseUrl => "https://api3-staging.changera.co";
  // dotenv.env['PROD_BASE_URL'] ?? "https://api3-staging.changera.co";

  String get dojahWidgetId => dotenv.env['STAGING_DOJAH_WIDGET_ID'] ?? "";
  String get dojahAppId => dotenv.env['STAGING_DOJAH_APPID'] ?? "";
  String get dojahPublicKey => dotenv.env['STAGING_DOJAH_PUBLIC_KEY'] ?? "";

  String get appId => dotenv.env['STAGING_APP_ID'] ?? "";
  String get intercomAndroidApiKey =>
      dotenv.env['STAGING_ANDROID_API_KEY'] ?? "";
  String get inetercomIosApiKey => dotenv.env['STAGING_IOS_API_KEY'] ?? "";

  // aws bucket keys
  // digitalOceanBucketUrlKey: env[digitalOceanBucketUrl]!,
  // digitalOceanAccessKeyString: env[digitalOceanAccessKey]!,
  // digitalOceanProjectNameKey: env[digitalOceanProjectName]!,
  // digitalOceanSecret: env[digitalOceanSecretKey]!,
  // digitalOceanEndpointKey: env[digitalOceanEndpoint]!,
  // digitalOceanRegionKey: env[digitalOceanRegion]!,

  String get digitalOceanBucketUrl =>
      dotenv.env['STAGING_DIGITAL_OCEAN_BUCKET_URL'] ?? "";
  String get digitalOceanAccessKey =>
      dotenv.env['STAGING_DIGITAL_OCEAN_ACCESS_KEY'] ?? "";
  String get digitalOceanProjectName =>
      dotenv.env['STAGING_DIGITAL_OCEAN_PROJECT_NAME'] ?? "";
  String get digitalOceanSecretKey =>
      dotenv.env['STAGING_DIGITAL_OCEAN_SECRET_KEY'] ?? "";
  String get digitalOceanEndpoint =>
      dotenv.env['STAGING_DIGITAL_OCEAN_ENDPOINT'] ?? "";
  String get digitalOceanRegion =>
      dotenv.env['STAGING_DIGITAL_OCEAN_REGION'] ?? "";
}
