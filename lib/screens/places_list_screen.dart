// packages
import 'package:flutter/material.dart';
import 'package:great_places/providers/places_provider.dart';
// screens
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Importing places...'),
                      ],
                    ),
                  )
                : Consumer<PlacesProvider>(
                    child: Center(
                      child: const Text('places is not exists yet'),
                    ),
                    builder: (BuildContext ctx, PlacesProvider placesProvider,
                            Widget? ch) =>
                        placesProvider.places.length <= 0
                            ? ch as Widget
                            : ListView.builder(
                                itemCount: placesProvider.places.length,
                                itemBuilder: (ctx, i) => ListTile(
                                  title: Text(placesProvider.places[i].title),
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                      placesProvider.places[i].image,
                                    ),
                                  ),
                                ),
                              ),
                  ),
      ),
    );
  }
}
