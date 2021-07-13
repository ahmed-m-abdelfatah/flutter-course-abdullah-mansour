// base url : https://newsapi.org/
// method (url) = pathUrl : v2/top-headlines?
// queries : country=eg&category=business&apiKey=74c46aa019f2472a8f80a48776f97d95
// https://newsapi.org/v2/everything?q=tesla&apiKey=74c46aa019f2472a8f80a48776f97d95

String baseUrl = 'https://newsapi.org/';
String pathUrl = 'v2/top-headlines';
String pathSearch = 'v2/everything';
String apiKey = '74c46aa019f2472a8f80a48776f97d95';

Map<String, dynamic> businessQuery = {
  'country': 'eg',
  'category': 'business',
  'apiKey': apiKey,
};
Map<String, dynamic> sportsQuery = {
  'country': 'eg',
  'category': 'sports',
  'apiKey': apiKey,
};
Map<String, dynamic> scienceQuery = {
  'country': 'eg',
  'category': 'science',
  'apiKey': apiKey,
};
Map<String, dynamic> searchQuery(String value) => {
      'q': value,
      'apiKey': apiKey,
    };
