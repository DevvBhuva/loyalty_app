import 'package:flutter/material.dart';
import '../models/card_model.dart';
import 'add_card_page.dart';
import 'card_detail_page.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final List<CardModel> _cards = [
    CardModel(cardName: 'Axis', cardNumber: '1234567890123456', barcode: 'AXIS123', cvv: '123'),
    CardModel(cardName: 'SBI', cardNumber: '9876543210987654', barcode: 'SBI123', cvv: '456'),
    CardModel(cardName: 'HDFC', cardNumber: '1122334455667788', barcode: 'HDFC123', cvv: '789'),
    CardModel(cardName: 'Kotak', cardNumber: '2233445566778899', barcode: 'KOTAK123', cvv: '101'),
    CardModel(cardName: 'ICICI', cardNumber: '3344556677889900', barcode: 'ICICI123', cvv: '202'),
    CardModel(cardName: 'BOB', cardNumber: '4455667788990011', barcode: 'BOB123', cvv: '303'),
  ];

  void _addCard(CardModel card) {
    setState(() {
      _cards.add(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                card.cardName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Card Number: ${card.cardNumber}\nBarcode: ${card.barcode}',
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to CardDetailPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetailPage(card: card),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCardPage(onCardAdded: _addCard),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}