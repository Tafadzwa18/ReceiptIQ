import 'package:flutter/material.dart';
import '../services/receipt_parser_service.dart';
import 'receipt_details_screen.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

class RawTextView extends StatefulWidget {
  final File imageFile;

  const RawTextView({super.key, required this.imageFile});

  @override
  State<RawTextView> createState() => _RawTextViewState();
}

class _RawTextViewState extends State<RawTextView> {
  String _rawText = '';
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _processImage();
  }

  Future<void> _processImage() async {
    final inputImage = InputImage.fromFile(widget.imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    
    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      setState(() {
        _rawText = recognizedText.text;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _rawText = 'Error recognizing text: $e';
        _isProcessing = false;
      });
    } finally {
      textRecognizer.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raw OCR Text'),
      ),
      body: _isProcessing
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _rawText,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final parsed = ReceiptParserService.parse(_rawText);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiptDetailsScreen(receipt: parsed),
                        ),
                      );
                    },
                    child: const Text('Parse & Review'),
                  ),
                ],
              ),
            ),
    );
  }
}
