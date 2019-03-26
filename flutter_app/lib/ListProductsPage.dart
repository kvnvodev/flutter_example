import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ListProductsPage extends StatefulWidget {
  @override
  _ListProductsPageState createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  final _suggestions = <WordPair>[];

  @override
  void initState() {
    super.initState();
    print("init state");
    _suggestions.addAll(generateWordPairs().take(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Products"),
      ),
      body: _buildListProducts(),
    );
  }

  Widget _buildProduct(WordPair name) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.brown, style: BorderStyle.solid)
      ),
      child: Text(name.first + " " + name.second),
    );
  }

  Widget _productBuilder(BuildContext context, int i) {
    print("$i");
    return _buildProduct(_suggestions[i]);
  }

  Widget _buildListProducts() {
    return ListView.builder(itemCount: _suggestions.length, itemBuilder: _productBuilder);
  }
}