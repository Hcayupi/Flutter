class Personajes{
String? name = "";
int? height=0;
int? mass=0;
String? haircolor= "";
String? skincolor= "";
String? eyecolor= "";
String? birthyear= "";
String? gende= "";
String? homeworld= "";
List<dynamic>? films;
List<dynamic>? species;
List<dynamic>? vehicles;
List<dynamic>? starships;
String? created;
String? edited;
String? url;



Personajes({this.name,this.height,this.mass, this.haircolor,
this.skincolor, this.eyecolor,this.birthyear,this.gende, 
this.homeworld,this.films,this.species,this.vehicles,
this.starships,this.created,this.edited,this.url});




Personajes.fromMap(Map<String, dynamic> map)
  :name=map["name"],
  height= (int.tryParse(map["height"]))as int,
  mass=(int.tryParse(map["mass"])) as int , 
  haircolor=map["hair_color"], 
  skincolor=map["skin_color"], 
  eyecolor=map["eye_color"], 
  birthyear=map["birth_year"], 
  gende=map["gende"]??'', 
  homeworld=map["homeworld"], 
  films=map["films"], 
  species=map["species"], 
  vehicles=map["vehicles"], 
  starships=map["starships"], 
  created=map["created"], 
  edited=map["edited"], 
  url=map["url"];

}