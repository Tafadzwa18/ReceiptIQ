import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/receipt.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late Future<List<Receipt>> _receiptsFuture;

  @override
  void initState() {
    super.initState();
    _refreshReceipts();
  }

  void _refreshReceipts() {
    setState(() {
      _receiptsFuture = DatabaseService.instance.readAllReceipts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
      ),
      body: FutureBuilder<List<Receipt>>(
        future: _receiptsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No expenses recorded yet.'));
          }

          final receipts = snapshot.data!;
          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    child: const Icon(Icons.receipt, color: Colors.blue),
                  ),
                  title: Text(receipt.merchantName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${receipt.date} • ${receipt.category}'),
                  trailing: Text(
                    '\$${receipt.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
