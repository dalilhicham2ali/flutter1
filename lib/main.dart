import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Pour les icônes Google Maps
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recherche Pharmacie',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<Map<String, dynamic>> _allPharmacies = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadPharmacies();
  }

  Future<void> _loadPharmacies() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('pharmacie').get();
      final pharmacies = snapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        _allPharmacies = pharmacies;
        _searchResults = pharmacies;
      });
    } catch (e) {
      print("Erreur lors du chargement des pharmacies : $e");
    }
  }

  void _search(String query) {
    setState(() {
      _isSearching = true;
    });

    final searchQuery = query.trim().toLowerCase();
    if (searchQuery.isEmpty) {
      setState(() {
        _searchResults = _allPharmacies;
        _isSearching = false;
      });
      return;
    }

    final results = _allPharmacies.where((doc) {
      final ville = (doc['ville'] ?? '').toString().toLowerCase();
      return ville.contains(searchQuery);
    }).toList();

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir l\'URL : $url';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche Pharmacie'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Entrez la ville',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onChanged: (value) {
                  _search(value);
                },
              ),
              const SizedBox(height: 16),
              if (_isSearching)
                const Center(child: CircularProgressIndicator())
              else
                ..._searchResults.map((result) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result["nom"] ?? 'Nom non spécifié',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: (result['disponible'] == true)
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  (result['disponible'] == true)
                                      ? 'Disponible'
                                      : 'Non disponible',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (result["googlemap"] != null)
                                IconButton(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _launchURL(result["googlemap"] ?? '');
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
