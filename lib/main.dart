import 'package:flutter/material.dart';

void main() {
  runApp(const ImcApp());
}

class ImcApp extends StatelessWidget {
  const ImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator IMC',
      home: const ImcScreen(),
    );
  }
}

class ImcScreen extends StatefulWidget {
  const ImcScreen({super.key});

  @override
  State<ImcScreen> createState() => _ImcScreenState();
}

class _ImcScreenState extends State<ImcScreen> {
  final _greutateController = TextEditingController();
  final _inaltimeController = TextEditingController();

  String _rezultat = '';
  String _categorie = '';

  String _categoriePentru(double imc) {
    if (imc < 18.5) return 'Subponderal';
    if (imc < 25) return 'Normal';
    if (imc < 30) return 'Supraponderal';
    return 'Obezitate';
  }

  void _calculeaza() {
    final greutate = double.tryParse(_greutateController.text);
    final inaltime = double.tryParse(_inaltimeController.text);

    if (greutate == null || inaltime == null || greutate <= 0 || inaltime <= 0) {
      setState(() {
        _rezultat = '';
        _categorie = 'Introduceți valori numerice valide';
      });
      return;
    }

    final inaltimeInMetri = inaltime / 100;
    final imc = greutate / (inaltimeInMetri * inaltimeInMetri);

    setState(() {
      _rezultat = 'IMC: ${imc.toStringAsFixed(1)}';
      _categorie = _categoriePentru(imc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator IMC')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _greutateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Greutate (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _inaltimeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Înălțime (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculeaza,
              child: const Text('Calculează'),
            ),
            const SizedBox(height: 32),
            Text(_rezultat, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(_categorie, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
