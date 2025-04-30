import 'package:hive/hive.dart';
import '../models/card_model.dart';

class HiveService {
  static Future<void> initializeHive() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CardModelAdapter());
    }

    if (!Hive.isBoxOpen('cards')) {
      await Hive.openBox<CardModel>('cards');
    }
  }

  static Box<CardModel> getCardBox() {
    return Hive.box<CardModel>('cards');
  }
}