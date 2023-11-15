class EndPoints {
  //
  // API.
  static const String BASE_URL = 'http://p55product10test.izisoft.io/v1';
  static const String SOCKET_URL = 'wss://socket1.crudcode.tk';

  //
  // Auth.
  static const String signInAccount = '/auth/signin-with-device';

  // Characters.
  static const String character = '/a3-characters';

  // Category.
  static const String category = '/a3-categories';

  // Conversation.
  static const String conversation = '/a3-conversations';

  // messages.
  static const String messages = '/a3-messages';

  // Convert image.
  static const String convertFile = '/messages/upload-file-to-text';

  // Convert file.
  static const String convertImage = '/messages/upload-image-to-text';

  // Settings.
  static const String settings = '/settings';

  // Auth.
  static const String users = '/users';

  // DIY.
  static const String diy = '/a3-diy';

  // Tool collection.
  static const String toolCollection = '/a3-tool-categories';

  // Tool generator.
  static const String toolGenerator = '/a3-tool-categories/use';

  // DIY Chat.
  static const String diyChat = '/a3-diy-messages';

  // 
  static  const String policy_terms = '/settings/one?appType=A4_MATH';
  
  static const String feedback = '/a4-feedbacks';
  static const String share = '/a4-link-shares';

  // Verify Receipt Apple.
  static const String receiptAppleSanBox = 'https://sandbox.itunes.apple.com/verifyReceipt';
  static const String receiptAppleProduct = 'https://buy.itunes.apple.com/verifyReceipt';
}
