import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_test/main_file_flavors/widgets/flavor_banner.dart';
import 'package:flutter/material.dart';

import '../../flavor/flavor_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseFirestore _firestore;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      _firestore = FirebaseFirestore.instance;
      setState(() {});
    });

    super.initState();
  }

  Stream<List<teste>> getData() {
    Stream<List<teste>> returnList;
    returnList = _firestore.collection('teste').snapshots().map((query) {
      return query.docs.map(
        (doc) {
          return teste(doc['tipo']);
        },
      ).toList();
    });

    return returnList;
  }

  Future<void> addTeste() async {
    await _firestore.collection('teste').add({'tipo': _controller.text});
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(title: const Text('Flutter Ready to Go')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flavor: ${FlavorConfig.instance.name}',
            ),
            TextFormField(
              controller: _controller,
            ),
            StreamBuilder<List<teste>>(
              stream: getData(),
              builder: ((context, snapshot) {
                print('------------');
                print(snapshot.hasError);
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          teste t = teste(snapshot.data![index].tipo);
                          return Text(t.tipo);
                        }),
                  );
                } else {
                  return const Text('sem dados');
                }
              }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addTeste(),
        ),
      ),
    );
  }
}

class teste {
  final String tipo;
  teste(this.tipo);
}
