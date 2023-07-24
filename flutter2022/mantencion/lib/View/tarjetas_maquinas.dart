import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mantencion/Controller/data_base_handler.dart';
import 'package:mantencion/Model/maquina.dart';
import 'package:mantencion/View/detalle_maquina.dart';

class TarjetasMaquinas extends StatefulWidget {
  const TarjetasMaquinas({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TarjetasMaquinasState();
}

class TarjetasMaquinasState extends State<TarjetasMaquinas> {
  TarjetasMaquinasState();
  List<Maquina> listaMaquinas = [];

  @override
  void initState() {
    super.initState();
    getListaMaquinas();
  }

  @override
  Widget build(BuildContext context) {
    Color colorFondo = const Color(0xFF0063b2);
    return Scaffold(
      backgroundColor: colorFondo,
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 0.0,
                backgroundColor: colorFondo,
                automaticallyImplyLeading: false,
                flexibleSpace: const FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(bottom: 45),
                  centerTitle: true,
                  title: Text('Registro de mantención',
                      style: TextStyle(color: Colors.white)),
                ),
                floating: true,
                expandedHeight: 100.0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listaMaquinas.length,
              itemBuilder: (BuildContext context, int index) {
                return tarjetasMaquinas(listaMaquinas[index]);
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/NuevaMaquina');
        },
        child: const Icon(
          Icons.app_registration,
          color: Colors.black,
          semanticLabel: "Nueva máquina",
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
    );
  }

  Hero tarjetasMaquinas(Maquina maquina) {
    Color colorTexto = const Color(0XFFFFFFFF);
    double sizeTexto = 20;
    return Hero(
        tag: maquina.id.toString(),
        child: GestureDetector(
          child: Card(
              color: const Color(0xFF00b2a7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 125,
                child: Row(children: <Widget>[
                  const FlutterLogo(size: 100),
                  Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        const Padding(padding: EdgeInsets.all(10)),
                        Flexible(
                            child: Text(
                          maquina.nombre,
                          style: TextStyle(
                              color: colorTexto,
                              fontSize: sizeTexto,
                              overflow: TextOverflow.ellipsis),
                        )),
                        Flexible(
                            child: Text(
                                "Ultima lectura: " +
                                    maquina.lecturaPanel.toString(),
                                style: TextStyle(
                                    color: colorTexto,
                                    fontSize: sizeTexto,
                                    overflow: TextOverflow.ellipsis))),
                      ]))
                ]),
              )),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute<void>(
                fullscreenDialog: true,
                builder: (BuildContext context) =>
                    DetalleMaquina(maquina: maquina),
              ),
            );
          },
        ));
  }

  Card miCardImageCarga() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: <Widget>[
              const FadeInImage(
                // En esta propiedad colocamos la imagen a descargar
                image: NetworkImage(
                    'https://staticuestudio.blob.core.windows.net/buhomag/2016/03/01195417/pexels-com.jpg'),

                // En esta propiedad colocamos el gif o imagen de carga
                // debe estar almacenado localmente
                placeholder: AssetImage('assets/loading.gif'),

                // En esta propiedad colocamos mediante el objeto BoxFit
                // la forma de acoplar la imagen en su contenedor
                fit: BoxFit.cover,

                // En esta propiedad colocamos el alto de nuestra imagen
                height: 260,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Paisaje con carga'),
              )
            ],
          ),
        ));
  }

  getListaMaquinas() {
    Future.wait({DatabaseHandler.instance.listaMaquinas()}).then((value) {
      for (var elemento in value) {
        for (var maquina in elemento) {
          if (mounted) {
            setState(() {
              listaMaquinas.add(maquina);
            });
          }
        }
      }
    });
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(size.width * 0.5, -150), radius: 350));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
