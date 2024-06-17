import 'package:flutter/material.dart';
import 'package:quotes_api_demo/Controllers/HomeController.dart';

class RandomQuotePage extends StatefulWidget {
  const RandomQuotePage({super.key});

  @override
  _RandomQuotePageState createState() => _RandomQuotePageState();
}

class _RandomQuotePageState extends State<RandomQuotePage> {
  late Future<String> randomQuote;

  @override
  void initState() {
    super.initState();
    randomQuote = HomeController.fetchRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Quote'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: randomQuote,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data ?? 'No quote available',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              randomQuote = HomeController.fetchRandomQuote(getNext: false);
                            });
                          },
                          child: Text('Previous'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              randomQuote = HomeController.fetchRandomQuote();
                            });
                          },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

