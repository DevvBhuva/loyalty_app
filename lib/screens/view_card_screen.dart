import 'package:flutter/material.dart';
import '../models/card_model.dart';

class ViewCardScreen extends StatelessWidget {
  final CardModel card;

  const ViewCardScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.cardName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Card Name: ${card.cardName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Card Number: ${card.cardNumber}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'CVV: ${card.cvv}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Barcode: ${card.barcode}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Expiration Date: ${card.expirationDate != null ? '${card.expirationDate!.day}/${card.expirationDate!.month}/${card.expirationDate!.year}' : 'No expiration date'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}