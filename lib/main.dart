import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraIdadeApp());
}

class CalculadoraIdadeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Idade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraIdadeScreen(),
    );
  }
}

class CalculadoraIdadeScreen extends StatefulWidget {
  @override
  _CalculadoraIdadeScreenState createState() => _CalculadoraIdadeScreenState();
}

class _CalculadoraIdadeScreenState extends State<CalculadoraIdadeScreen> {
  final TextEditingController _dataNascimentoController = TextEditingController();
  String _idadeCalculada = '';
  Color _backgroundColor = Colors.white;

  void _calcularIdade() {
    List<String> partesData = _dataNascimentoController.text.split('/');
    if (partesData.length == 3) {
      int? dia = int.tryParse(partesData[0]);
      int? mes = int.tryParse(partesData[1]);
      int? ano = int.tryParse(partesData[2]);

      if (dia != null && mes != null && ano != null) {
        DateTime dataNascimento = DateTime(ano, mes, dia);
        DateTime hoje = DateTime.now();
        int idade = hoje.year - dataNascimento.year;
        if (hoje.month < mes || (hoje.month == mes && hoje.day < dia)) {
          idade--;
        }
        setState(() {
          _idadeCalculada = 'Idade: $idade anos';
          _backgroundColor = _getRandomLightColor();
        });
        return;
      }
    }

    setState(() {
      _idadeCalculada = 'Data inválida';
    });
  }

  Color _getRandomLightColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      200 + random.nextInt(56), // Red component (200-255)
      200 + random.nextInt(56), // Green component (200-255)
      200 + random.nextInt(56), // Blue component (200-255)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Idade'),
      ),
      body: Container(
        color: _backgroundColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _dataNascimentoController,
              decoration: InputDecoration(labelText: 'Data de Nascimento (dia/mes/ano)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularIdade,
              child: Text('Calcular Idade'),
            ),
            SizedBox(height: 16),
            Text(
              _idadeCalculada,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
