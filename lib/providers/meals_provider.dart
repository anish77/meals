import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

// using Provider((ref) is using for the data tha will Not change
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
