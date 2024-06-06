import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_api/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "24", "start": "0", "tag": "list.recipe.popular"});

    try {
      final response = await http.get(uri, headers: {
        'x-rapidapi-key': '81a8d5ef57msh27c770c9aeb1235p180f5fjsn6ec1f8d54f17',
        'x-rapidapi-host': 'yummly2.p.rapidapi.com',
      });

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        List temp = [];

        for (var i in data['feed']) {
          temp.add(i['content']['details']);
        }

        return Recipe.recipesFromSnapshot(temp);
      } else {
        print('Failed to load recipes. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to load recipes: $e');
    }
  }
}
