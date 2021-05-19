import 'dart:convert';
import 'dart:io';

import 'package:flutter_shutterstock_infinite_list/models/models.dart';

class ShutterstockApiProvider {
  final _httpClient;

  ShutterstockApiProvider(this._httpClient);

  Future<List<ImageModel>> fetchImages(int startIndex, int perPage) async {
    final response = await _httpClient.get(
      Uri.https(
        'api.shutterstock.com',
        '/v2/images/search',
        <String, String>{
          'contributor_country': 'US',
          'image_type': 'photo',
          'language': 'en',
          'orientation': 'vertical',
          'page': '$startIndex',
          'per_page': '$perPage',
          'region': 'US',
          'sort': 'popular',
          'spellcheck_query': 'true'
        },
      ),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer v2/eW1JSEhuZXZydkFjOTVET1RWdUxpQThWREdwa0Vxa1EvMzAxMjU5Mzk5L2N1c3RvbWVyLzQveGFWRS12SXNWZmVFVXhZOEFoclpHUW1CR2Ntem52dzdPV2VhZmZiS3YxRkNrU0Mtdkh2QThLMDNsOXBBSnB4TFRub3dFLW4tUm9fOW96S2Q5elB0S3JpMUVEdFE3M19fU2ZwOUk4Um80VFZWM3ZsT3ZZZ3NqcHhqQU1vUUhPRVFoRXNGRXR4OXA0Q3l5MUxBVzNra2xpT05vbG82N01XZDhsLW5fNHgwbWZxcXZoa0lfdnJ1TFZSZERhT2tVS25PRmRWdlU4bGNTOEpBcHhkb3lka0RnZy9aMWZ5cXcyb3pwell1cXItZE5HcFpn',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.userAgentHeader: 'flutter app',
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data'] as List;
      return body.map((dynamic json) {
        return ImageModel(
          id: json['id'] as String,
          description: json['description'] as String,
          url: json['assets']['preview_1000']['url'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
