import 'package:flutter/material.dart';
import 'package:rickandmorty_project/models/character_model.dart';
import 'package:rickandmorty_project/services/api_services.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  bool isLoading = true;
  final ApiServices _services = ApiServices();
  late CharacterModel _characterModel;

  @override
  void initState() {
    super.initState();
    _loadScreen();
  }

  void _loadScreen() async {
    var result = await _services.fetchData('https://rickandmortyapi.com/api/character/');
    _characterModel = CharacterModel.fromJson(result);

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 43, 51),
      appBar: AppBar(
        title: const Text(
          'Rick and Morty',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 22, 26),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : ListView.builder(
              itemCount: _characterModel.results!.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Color.fromARGB(255, 60, 62, 68),
                          elevation: 5,
                          borderOnForeground: true,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 3),
                              Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(
                                      _characterModel.results![index].image!,
                                      width: 170,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _characterModel.results![index].name!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: _characterModel.results![index].status == 'Alive'
                                                ? Colors.green[300]
                                                : _characterModel.results![index].status == 'Dead'
                                                    ? Colors.red[400]
                                                    : Colors.grey[700],
                                            size: 10,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              '${_characterModel.results![index].species} - ${_characterModel.results![index].status}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Last known Location:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 158, 158, 158),
                                        ),
                                      ),
                                      Text(
                                        _characterModel.results![index].location!.name!,
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'First seen in:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 158, 158, 158),
                                        ),
                                      ),
                                      Text(
                                        _characterModel.results![index].origin!.name!,
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
