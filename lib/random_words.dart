import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();
          final index = item ~/ 2;

          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alradySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        alradySaved ? Icons.favorite : Icons.favorite_border,
        color: alradySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alradySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 16),
          ),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text("Saved WordPairs"),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Pair Generatoe"),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ),
      body: _buildList(),
    );
  }
}
