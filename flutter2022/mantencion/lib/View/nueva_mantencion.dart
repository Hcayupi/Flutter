import 'package:flutter/material.dart';
import 'package:mantencion/Model/maquina.dart';

class NuevaMantencion extends StatefulWidget {
  final Maquina maquina;
  const NuevaMantencion({Key? key, required this.maquina}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NuevaMantencionState();
}

class NuevaMantencionState extends State<NuevaMantencion> {
  TextEditingController controllerNombreMaquina = TextEditingController();
  GlobalKey<FormState> keyFormMantencion = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: DrawClip(),
          child: Container(
            height: size.height,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.blue),
            /*  decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff46ddbf), Color(0xff3088e2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft)),*/
            child: Column(
              children: const [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
                /*  SizedBox(
                  //height: size.height,
                  // width: double.infinity,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      /*SizedBox(
                        height: 40,
                      ),*/
                      /*Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Today',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )*/
                      /* const SizedBox(
                        height: 10,
                      ),*/
                      /*Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text('ok'),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
        Positioned(
          top: 240,
          child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: const Center(
                  child: Text(
                    'Here',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));

    /* return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
              key: keyFormMantencion,
              child: Column(
                children: <Widget>[
                  TextFormFieldWidget("Nombre máquina: ",
                      controller: controllerNombreMaquina),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Cambio de aceite de:"),
                  RollingSwitchWidget(
                      labelText: "Motor: ", onChanged: (bool state) {})
                ],
              ))),
    ));*/
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(size.width * 0.5, 50), radius: 300));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
