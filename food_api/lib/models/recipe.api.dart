import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_api/models/recipe.dart';

class RecipeApi {
//   const unirest = require('unirest');

// const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');

// req.query({
// 	limit: '24',
// 	start: '0'
// });

// req.headers({
// 	'x-rapidapi-key': '81a8d5ef57msh27c770c9aeb1235p180f5fjsn6ec1f8d54f17',
// 	'x-rapidapi-host': 'yummly2.p.rapidapi.com'
// });

  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('https://yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "24", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      'x-rapidapi-key': '81a8d5ef57msh27c770c9aeb1235p180f5fjsn6ec1f8d54f17',
      'x-rapidapi-host': 'yummly2.p.rapidapi.com',
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List temp = [];

    for (var i in data['feed']) {
      temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(temp);
  }
}
