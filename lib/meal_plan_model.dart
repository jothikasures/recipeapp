import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recipeapp/recipe_model.dart';


class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static String get API_KEY => '7e91b0a2c25848f7ae57f3fe41823c0f';

  get MealPlan => null;

  Future fetchMealPlan({required int targetCalories, String diet = ''}) async {
    Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(_baseUrl, '/mealplanner/generate', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Send the HTTP request
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MealPlan.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load meal plan');
    }
  }

  generateMealPlan({required int targetCalories, required String diet}) {}

  fetchRecipe(String string) {}
}

mixin MealPlan {
  var calories;

  var protein;

  var carbs;

  get fat => null;

  get meals => null;
}

Future<Recipe> fetchRecipe(String id) async {
  var API_KEY;
  Map<String, String> parameters = {
    'includeNutrition': 'false',
    'apiKey': API_KEY,
  };
  Uri uri = Uri.https(_baseUrl as String, '/recipes/$id/information', parameters);
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  try {
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    } else {
      throw Exception('Failed to load recipe');
    }
  } catch (err) {
    throw err.toString();
  }
}

mixin _baseUrl {
}

