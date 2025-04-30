import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/card_model.dart';
import 'card_detail_screen.dart';
import 'view_card_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loyalty Cards'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CardModel>('cards').listenable(),
        builder: (context, Box<CardModel> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No cards added yet.'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final card = box.getAt(index);
              return ListTile(
                title: Text(card?.cardName ?? 'Unnamed Card'),
                subtitle: Text(card?.cardNumber ?? ''),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  if (card != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewCardScreen(card: card),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CardDetailScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}