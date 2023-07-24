import 'package:appstarwars/api.dart';
import 'package:appstarwars/personajes.dart';
import 'package:flutter/material.dart';

class ConexionApi extends StatefulWidget {
  const ConexionApi({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConexionApiState();
}

class ConexionApiState extends State<ConexionApi> {
  Personajes personaje = Personajes();
  @override
  Widget build(Object context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(children: <Widget>[
            Center(
              child: FutureBuilder(
                  future: conexionApi(),
                  builder: (BuildContext context, AsyncSnapshot projectSnap) {
                    if (projectSnap.connectionState ==
                        ConnectionState.waiting) {
                      personaje = projectSnap.data ?? Personajes();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        if (projectSnap.connectionState ==
                            ConnectionState.done) {
                          return Column(children: <Widget>[
                            Text(personaje.name ?? ""),
                            Text(personaje.height.toString()),
                            Text(personaje.mass.toString())
                          ]);
                        } else {
                          return Column();
                        }
                      },
                    );
                  }),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Conectar a API"),
            )
          ]),
        ],
      ),
    );
  }
}
