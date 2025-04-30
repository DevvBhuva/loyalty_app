import 'package:flutter/material.dart';
import 'cards_page.dart';
import 'offers_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Cards and Offers
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Loyalty App'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.credit_card), text: 'Cards'),
              Tab(icon: Icon(Icons.local_offer), text: 'Offers'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CardsPage(), // Page for Cards
            OffersPage(), // Page for Offers
          ],
        ),
      ),
    );
  }
}