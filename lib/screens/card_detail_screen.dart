import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/card_model.dart';


class CardDetailScreen extends StatefulWidget {
  const CardDetailScreen({super.key});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  DateTime? _expirationDate;

  void _saveCard() async {
    final cardName = _cardNameController.text;
    final cardNumber = _cardNumberController.text;
    final barcode = _barcodeController.text;
    final cvv = _cvvController.text;

    if (cardName.isNotEmpty &&
        cardNumber.isNotEmpty &&
        barcode.isNotEmpty &&
        cvv.isNotEmpty &&
        _expirationDate != null) {
      final card = CardModel(
        cardName: cardName,
        cardNumber: cardNumber,
        barcode: barcode,
        expirationDate: _expirationDate, cvv: '',
      );

      final cardBox = Hive.box<CardModel>('cards');
      await cardBox.add(card);

      Navigator.pop(context); // Go back to the dashboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  void _pickExpirationDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );

    if (selectedDate != null) {
      setState(() {
        _expirationDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Card Name:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _cardNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Card Name',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Card Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Card Number',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'CVV:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter CVV',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Expiration Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    _expirationDate == null
                        ? 'No date selected'
                        : '${_expirationDate!.day}/${_expirationDate!.month}/${_expirationDate!.year}',
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _pickExpirationDate,
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Barcode:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _barcodeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Barcode',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveCard,
                child: const Text('Save Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}