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

  CardModel({
    required this.cardName,
    required this.cardNumber,
    required this.barcode, DateTime? expirationDate, required String cvv,
  });

  // Static map of predefined offers for each card type
  static final Map<String, List<String>> predefinedOffers = {
    'Axis': [
      '50% off on dining',
      '10% cashback on groceries',
      '5% discount on fuel',
      'Free movie tickets on weekends',
      'Exclusive airport lounge access',
    ],
    'SBI': [
      '60% off on travel bookings',
      '15% cashback on online shopping',
      '5% discount on utility bills',
      'Complimentary travel insurance',
      'Priority customer support',
    ],
    'HDFC': [
      '50% off on electronics',
      '10% cashback on dining',
      '5% discount on fuel',
      'Exclusive airport lounge access',
      'Free movie tickets every month',
    ],
    'Kotak': [
      '40% off on hotel bookings',
      '20% cashback on groceries',
      '5% discount on fuel',
      'Complimentary travel insurance',
      'Priority customer support',
    ],
    'ICICI': [
      '50% off on dining',
      '10% cashback on online shopping',
      '5% discount on fuel',
      'Exclusive airport lounge access',
      'Free movie tickets on weekends',
    ],
    'BOB': [
      '30% off on travel bookings',
      '15% cashback on groceries',
      '5% discount on fuel',
      'Complimentary travel insurance',
      'Priority customer support',
    ],
  };

  get expirationDate => null;

  get cvv => null;

  // Get offers for a specific card type
  static List<String> getOffers(String cardName) {
    return predefinedOffers[cardName] ?? [];
  }
}