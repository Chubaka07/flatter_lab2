class Endpoints {
  static String content({String query = 'subject:fiction', int limit = 10}) =>
      '/volumes?q=$query&maxResults=$limit';

  static String contentById(String id) => '/volumes/$id';
}