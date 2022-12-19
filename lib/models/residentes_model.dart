import 'dart:convert';

class User {
    User({
        required this.apellido,
        required this.direccion,
        required this.email,
        required this.nombre,
        required this.rol,
    });

    String apellido;
    String direccion;
    String email;
    String nombre;
    String rol;
    String? id;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        apellido: json["apellido"],
        direccion: json["direccion"],
        email: json["email"],
        nombre: json["nombre"],
        rol: json["rol"],
    );

    Map<String, dynamic> toMap() => {
        "apellido": apellido,
        "direccion": direccion,
        "email": email,
        "nombre": nombre,
        "rol": rol,
    };
}


// class Residentes {
//     Residentes({
//         required this.usuario1,
//         required this.usuario2,
//         required this.usuario3,
//     });

//     Usuario usuario1;
//     Usuario usuario2;
//     Usuario usuario3;

//     factory Residentes.fromJson(String str) => Residentes.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Residentes.fromMap(Map<String, dynamic> json) => Residentes(
//         usuario1: Usuario.fromMap(json["usuario1"]),
//         usuario2: Usuario.fromMap(json["usuario2"]),
//         usuario3: Usuario.fromMap(json["usuario3"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "usuario1": usuario1.toMap(),
//         "usuario2": usuario2.toMap(),
//         "usuario3": usuario3.toMap(),
//     };
// }
