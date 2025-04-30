import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class CardModel extends HiveObject {
  @HiveField(0)
  final String cardName;

  @HiveField(1)
  final String cardNumber;

  @HiveField(2)
  final String barcode;

  @HiveField(3)
  final DateTime? expirationDate;

  CardModel({
    required this.cardName,
    required this.cardNumber,
    required this.barcode,
    this.expirationDate,
  });
}