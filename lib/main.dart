import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

TextEditingController? _campo;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List letras = [];
  List repetidas = [];
  String valorCampo = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eri Concatenar',
      home: Scaffold(
        appBar: AppBar(title: const Text('Eri concatenar'), centerTitle: true, backgroundColor: Colors.green,),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.abc),
                    label: Text("Ingresa tu cadena"),
                    hintText: "aaabcca",
                    border: OutlineInputBorder()),
                controller: _campo,
                onChanged: (String valor)=> _cambio(valor)
              ),
            ),
            Container(
                color: const Color(0xfff2f2f2),
                width: double.infinity,
                height: 200,
                child: (valorCampo.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: _Resultado(letras: letras, repetidas: repetidas))
                    : const Center(
                        child: Text("Nada que mostrar", style: TextStyle(fontSize: 25))))
          ],
        ),
      ),
    );
  }
  void _cambio(String valor) {
    valorCampo = valor;
    if (valor.isNotEmpty) {
      _concatenar(valor);
    }
    setState(() {});
  }

  void _concatenar(String valor) { // aaabcca
    String palabra = valor;
    letras = [];
    repetidas = [];
    String temp = palabra[0];
    letras.add(temp);
    int cont = 1;
    for (int i = 1; i < palabra.length; i++) {
      if (temp == palabra[i]) {
        cont++;
      } else {
        letras.add(palabra[i]);
        temp = palabra[i];
        repetidas.add(cont);
        cont = 1;
      }
    }
    repetidas.add(cont);
  }


}

class _Resultado extends StatelessWidget {
  final List letras;
  final List repetidas;

  const _Resultado({Key? key, required this.letras, required this.repetidas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle superIndice = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red);
    TextStyle texto = const TextStyle(fontSize: 25);
    return ListView.builder(
        itemCount: letras.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int i) {
          return Row(
            children: [
              Text(letras[i], style: texto),
              (repetidas[i] > 1)
                  ? Padding(padding: const EdgeInsets.only(bottom: 10),
                      child: Text("${repetidas[i]} ",style: superIndice))
                  : const Text("")
            ],
          );
        });
  }
}
