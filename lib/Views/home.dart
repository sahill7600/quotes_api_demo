import 'package:flutter/material.dart';
import 'package:quotes_api_demo/Controllers/HomeController.dart';
import 'package:quotes_api_demo/Models/QuotesModel.dart';
import 'FavoriteQuotesPage.dart';
import 'RandomQuotePage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<QuotesModel> quotes;

  @override
  void initState() {
    super.initState();
    quotes = [];
    loadQuotes();
  }

  Future<void> loadQuotes() async {
    try {
      final List<QuotesModel> fetchedQuotes = await HomeController.getQuotes();
      setState(() {
        quotes = fetchedQuotes;
      });
    } catch (e) {
      print('Error loading quotes: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Insignia",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(icon:  Icon(Icons.favorite,color: Colors.red,),
            onPressed: (){
              _navigateToFavoriteQuotesPage();
            },
          )
          // IconButton(icon:  Icon(Icons.search), onPressed: (){
          //   showSearch(context: context, delegate: Search(QuotesList: QuotesData));
          // })
        ],
      ),
      drawer:  Drawer(
        child:  Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName:  const Text("Insignia App",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
              accountEmail:  const Text("InsigniaTechnolabs@gmail.com",style: TextStyle(fontSize: 14,color: Colors.white),),
              currentAccountPicture:  CircleAvatar(
                backgroundColor: Colors.blue[800],
                child:  const Text("Insignia",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),),
              ),

            ),
            ListTile(
              title:  const Text("Quotes",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing:  Icon(Icons.format_quote,size: 20,color: Colors.white,),
              onTap: (){

                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RandomQuotePage()));
              },
            ),
            const Padding(padding:  EdgeInsets.only(top: 10)),
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.grey[700],
            ),
            ListTile(
              title:  const Text("Favourite",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing:  Icon(Icons.favorite,size: 20,color: Colors.red,),
              onTap: (){
                _navigateToFavoriteQuotesPage();
                // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RandWords()));
              },
            ),
            const Padding(padding:  EdgeInsets.only(top: 10)),
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.grey[700],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            ListTile(
              title: Text("Close",style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: Icon(Icons.close,size: 20,color: Colors.white,),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: quotes != null
          ? ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(quotes[index].text),
                subtitle: Text(quotes[index].author),
                trailing: IconButton(
                  icon: Icon(quotes[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: quotes[index].isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      quotes[index].isFavorite = !quotes[index].isFavorite;
                    });
                  },
                ),
              ),
              Divider(),
            ],
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  void _navigateToFavoriteQuotesPage() {
    final List<QuotesModel> favoriteQuotes =
    quotes.where((quote) => quote.isFavorite).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteQuotesPage(favoriteQuotes),
      ),
    );
  }

}
