import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/card_model.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CardModel>('cards').listenable(),
        builder: (context, Box<CardModel> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No cards or offers available.'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final card = box.getAt(index);
              final offers = card?.getOffers() ?? [];

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(card?.cardName ?? 'Unnamed Card'),
                  subtitle: Text('Offers: ${offers.length}'),
                  children: offers.map((offer) {
                    return ListTile(
                      title: Text(offer),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}