class AppwriteConstants {
  static const String projectId = '650bc719b5f5608138de';

  static const String databaseId = '650be23e77c79f902481';
  
  static const String endPoint = 'https://cloud.appwrite.io/v1';


  static const String usersCollection = '650d012d1989f029c8ed';
  static const String tweetsCollection = '650d0a7993ec9eaad4f0';
  static const String notificationsCollection ='650d0a70e26ebcb88499';


  static const String imagesBucket = '650d122ebdeb6a1efd35';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
