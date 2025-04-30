import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/card_model.dart';

@HiveType(typeId: 0)
class CardModel extends HiveObject {
  // Existing fields...

  @HiveField(5)
  final List<String> redeemedOffers;
  
  var expirationDate;
  
  var cardNumber;
  
  var cardName;
  
  var barcode;
  
  var cvv;

  CardModel({
    required this.cardName,
    required this.cardNumber,
    required this.barcode,
    this.expirationDate,
    required this.cvv,
    this.redeemedOffers = const [],
  });
  
  static const Map<String, List<String>> predefinedOffers = {
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

  // Get offers for a specific card type
  List<String> getOffers(String cardName) {
    final allOffers = predefinedOffers[cardName] ?? [];
    return allOffers.where((offer) => !redeemedOffers.contains(offer)).toList();
  }

  // Redeem an offer
  void redeemOffer(String offer) {
    if (!redeemedOffers.contains(offer)) {
      redeemedOffers.add(offer);
      save(); // Save changes to Hive
    }
  }
}

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Static list of card names
    final List<String> cardNames = ['Axis', 'SBI', 'HDFC', 'Kotak', 'ICICI', 'BOB'];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: cardNames.length,
      itemBuilder: (context, index) {
        final cardName = cardNames[index];
        final cardModel = CardModel(
          cardName: cardName,
          cardNumber: '',
          barcode: '',
          cvv: '',
        );
        final offers = cardModel.getOffers(cardName);

        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            title: Text(
              cardName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Offers: ${offers.length}',
              style: const TextStyle(fontSize: 14),
            ),
            children: offers.map((offer) {
              return ListTile(
                leading: const Icon(Icons.local_offer, color: Colors.green),
                title: Text(
                  offer,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}