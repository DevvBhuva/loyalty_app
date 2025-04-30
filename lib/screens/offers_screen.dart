import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/card_model.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Loyalty Card App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/offers': (context) => const OffersScreen(),
      },
    ),
  );
}

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Offers'),
      ),
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
              final offers = CardModel?.getOffers() ?? [];

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

class SomeOtherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('Navigating to OffersScreen'); // Debug statement
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OffersScreen()),
        );
      },
      child: const Text('Go to Offers'),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: const Text('Welcome to the Loyalty Card App!'),
      ),
    );
  }
}