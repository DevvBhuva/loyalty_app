import 'package:hive/hive.dart';
import '../models/card_model.dart';

class HiveService {
  static Future<void> initializeHive() async {
    Hive.registerAdapter(CardModelAdapter());
    await Hive.openBox<CardModel>('cards');
  }

  static Box<CardModel> getCardBox() {
    return Hive.box<CardModel>('cards');
  }
}