import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];      // ?? [] if list is empty it will not show error because it will not work to load

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew:brews[index]);
      },
    );

    // brews.forEach((brew){
    //  print(brew.name);          // don't use this
    // print(brew.sugars);
    // print(brew.strength);
    // });

    // print(brews.documents);
    // for(var doc in brews.documents){
    //  print(doc.data);
    // }
  }
}
