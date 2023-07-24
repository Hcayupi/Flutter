import 'dart:convert';
import 'package:appstarwars/personajes.dart';
import 'package:http/http.dart';

Future<Personajes> conexionApi() async {
  Response response = await get(
      Uri(scheme: "https", host: "swapi.dev", path: "/api/people/1/"));
  final Map<String, dynamic> data = jsonDecode(response.body);

  Personajes personaje = Personajes.fromMap(data);

  print(data);

  return personaje;
}
