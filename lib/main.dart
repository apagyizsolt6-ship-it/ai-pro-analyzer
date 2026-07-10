import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(home: MatchListScreen()));

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});
  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  String _status = "Kapcsolódás...";

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/status'),
        headers: {
          'x-rapidapi-key': 'fcf69e221emsh614a3c3b3ce4f69p1a706fjsnc68e93cb26e3',
          'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
        },
      );
      
      if (response.statusCode == 200) {
        setState(() => _status = "Sikeres kapcsolat! API Működik.");
      } else {
        setState(() => _status = "Hiba: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _status = "Hálózati hiba: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Pro Analyzer")),
      body: Center(child: Text(_status, style: const TextStyle(fontSize: 20))),
    );
  }
}
