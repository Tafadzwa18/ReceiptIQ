import 'package:flutter/material.dart';
import '../services/receipt_parser_service.dart';
import '../services/database_service.dart';
import '../models/receipt.dart';
import '../services/receipt_parser_service.dart';

class ReceiptDetailsScreen extends StatefulWidget {
  final ParsedReceipt receipt;

  const ReceiptDetailsScreen({super.key, required this.receipt});

  @override
  State<ReceiptDetailsScreen> createState() => _ReceiptDetailsScreenState();
}

class _ReceiptDetailsScreenState extends State<ReceiptDetailsScreen> {
  late TextEditingController _merchantController;
  late TextEditingController _dateController;
  late TextEditingController _totalController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _merchantController = TextEditingController(text: widget.receipt.merchantName);
    _dateController = TextEditingController(text: widget.receipt.date);
    _totalController = TextEditingController(text: widget.receipt.totalAmount);
    _categoryController = TextEditingController(text: 'General');
  }

  @override
  void dispose() {
    _merchantController.dispose();
    _dateController.dispose();
    _totalController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _saveReceipt() async {
    final amount = double.tryParse(_totalController.text.replaceAll('\$', '').trim()) ?? 0.0;
    
    final newReceipt = Receipt(
      merchantName: _merchantController.text,
      date: _dateController.text,
      totalAmount: amount,
      category: _categoryController.text,
    );

    await DatabaseService.instance.create(newReceipt);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receipt saved successfully!')),
    );
    // Navigate back to dashboard (pop twice: Scanner View, then Dashboard)
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Receipt'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.receipt, size: 64, color: Colors.blueAccent),
            const SizedBox(height: 16),
            TextField(
              controller: _merchantController,
              decoration: const InputDecoration(
                labelText: 'Merchant Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _totalController,
              decoration: const InputDecoration(
                labelText: 'Total Amount',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveReceipt,
                child: const Text('Save Expense', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
