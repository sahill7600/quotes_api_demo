import 'package:flutter/material.dart';
import 'package:quotes_api_demo/Models/QuotesModel.dart';

class FavoriteQuotesPage extends StatelessWidget {
  final List<QuotesModel> favoriteQuotes;

  FavoriteQuotesPage(this.favoriteQuotes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Quotes'),
      ),
      body: favoriteQuotes.isNotEmpty
          ? ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(favoriteQuotes[index].text),
                subtitle: Text(favoriteQuotes[index].author),
                // trailing: IconButton(
                //   icon: Icon(Icons.favorite, color: Colors.red),
                //   onPressed: () {
                //     // Handle un-favoriting if needed
                //   },
                // ),
              ),
              Divider(),
            ],
          );
        },
      )
          : Center(
        child: Text('No favorite quotes yet.'),
      ),
    );
  }
}
