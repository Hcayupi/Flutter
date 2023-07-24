import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  final int idUsuario;
  const LoginView({required this.idUsuario, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  LoginViewState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        miCard(),
        miCardImage(),
        miCardDesign(),
        miCardImageCarga(),
      ],
    ));
  }

  Card miCard() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: Column(
          children: <Widget>[
            const ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text('Titulo'),
              subtitle: Text(
                  "Este es el subtitulo del card. Aquí podemos colocar la descripción de este card"),
              leading: Icon(Icons.home),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              ElevatedButton(onPressed: () {}, child: const Text("Aceptar")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Cancelar"))
            ])
          ],
        ));
  }

  Card miCardImage() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,

        // Dentro de esta propiedad usamos ClipRRect
        child: ClipRRect(
          // Los bordes del contenido del card se cortan usando BorderRadius
          borderRadius: BorderRadius.circular(30),

          // EL widget hijo que será recortado segun la propiedad anterior
          child: Column(
            children: <Widget>[
              // Usamos el widget Image para mostrar una imagen
              const Image(
                // Como queremos traer una imagen desde un url usamos NetworkImage
                image: NetworkImage(
                    'https://www.yourtrainingedge.com/wp-content/uploads/2019/05/background-calm-clouds-747964.jpg'),
              ),

              // Usamos Container para el contenedor de la descripción
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Montañas'),
              ),
            ],
          ),
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

  Card miCardDesign() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      color: const Color(0xFFE6EE9C),
      child: Column(
        children: <Widget>[
          const ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Titulo'),
            subtitle: Text(
                'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
            leading: Icon(Icons.home),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(onPressed: () {}, child: const Text("Aceptar")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Cancelar"))
            ],
          )
        ],
      ),
    );
  }
}
