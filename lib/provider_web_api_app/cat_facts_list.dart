import 'package:flutter/material.dart';
import 'package:flutter_samples/provider_web_api_app/cat_fact_details.dart';
import 'package:flutter_samples/provider_web_api_app/cat_fact_model.dart';
import 'package:flutter_samples/provider_web_api_app/cat_store.dart';
import 'package:provider/provider.dart';

class ProviderWebApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _catsStore = Provider.of<CatsStore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cat facts app'),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            child: Consumer<CatsStore>(
              builder: (BuildContext context,CatsStore catStore, Widget child) {
                return Text(
                  'posts read: ${_catsStore.factsRead}',
                  style: Theme.of(context).primaryTextTheme.title,
                );
              },
            ),
            /*child: Text(
              'posts read: ${_catsStore.factsRead}',
              style: Theme.of(context).primaryTextTheme.title,
            ),*/
          ),
        ],
      ),
      body: Consumer<CatsStore>(
        builder: (context, catStore, child) {
          if (_catsStore.state == LoadingState.loading)
            return Center(child: CircularProgressIndicator());
          else if (_catsStore.state == LoadingState.none)
            return ListView.builder(
              itemCount: _catsStore.catFacts.length,
              itemBuilder: (context, index) {
                final catFact = _catsStore.catFacts[index];
                return CatFactsTile(catFact: catFact);
              },
            );
          else
            return Center(child: Text('There was an error'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        onPressed: _catsStore.fetchCatsFacts,
      ),
    );
  }
}

class CatFactsTile extends StatelessWidget {
  const CatFactsTile({
    Key key,
    @required this.catFact,
  }) : super(key: key);

  final CatFact catFact;

  @override
  Widget build(BuildContext context) {
    final _catsStore = Provider.of<CatsStore>(context, listen: false);
    return ListTile(
      onTap: () {
        _catsStore.incrementFactsRead();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CatFactPage(catFact: catFact),
          ),
        );
      },
      title: Text(catFact.userName),
      subtitle: Text(catFact.text),
    );
  }
}
