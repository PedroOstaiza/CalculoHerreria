import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// CONTROLLERS
  final txtAncho = TextEditingController(text: "1.76");
  final txtAlto = TextEditingController(text: "1.76");
  final txtSeparacion = TextEditingController(text: "0.15");
  final txtPrecioAngulo = TextEditingController(text: "6");
  final txtPrecioVarilla = TextEditingController(text: "6");
  final txtValorVarios = TextEditingController(text: "0");
  final txtFactorGanancia = TextEditingController(text: "2");

  /// RESULTADOS
  String lblMetrosAngulo = "0";
  String lblBarrasAngulo = "0";
  String lblLineas = "0";
  String lblMetrosVarilla = "0";
  String lblBarrasVarilla = "0";
  String lblCostoMateriales = "\$0";
  String lblTotal = "\$0";

  /// CALCULAR
  void calcular() {
    double ancho = double.parse(txtAncho.text.replaceAll(",", "."));

    double alto = double.parse(txtAlto.text.replaceAll(",", "."));

    double separacion = double.parse(txtSeparacion.text.replaceAll(",", "."));

    double varios = double.parse(txtValorVarios.text.replaceAll(",", "."));

    double factorGanancia = double.parse(
      txtFactorGanancia.text.replaceAll(",", "."),
    );

    double precioAngulo = double.parse(
      txtPrecioAngulo.text.replaceAll(",", "."),
    );

    double precioVarilla = double.parse(
      txtPrecioVarilla.text.replaceAll(",", "."),
    );

    /// MARCO
    double metrosAngulo = (ancho * 2) + (alto * 2);

    /// BARRAS
    double barrasAngulo = (metrosAngulo / 6).ceilToDouble();

    /// LINEAS
    double lineas = ((ancho / separacion).round() - 1) * 2;

    /// DIAGONAL
    double diagonal = sqrt((ancho * ancho) + (alto * alto));

    /// METROS VARILLA
    double metrosVarilla = ((diagonal / 2) * lineas) * 1.45;

    double barrasVarilla = (metrosVarilla / 6).ceilToDouble();

    /// COSTOS
    double costoMateriales =
        (barrasAngulo * precioAngulo) + (barrasVarilla * precioVarilla);

    double total = (costoMateriales + varios) * factorGanancia;

    /// ACTUALIZAR UI
    setState(() {
      lblMetrosAngulo = metrosAngulo.toStringAsFixed(2);

      lblBarrasAngulo = barrasAngulo.toStringAsFixed(0);

      lblLineas = lineas.toStringAsFixed(0);

      lblMetrosVarilla = metrosVarilla.toStringAsFixed(2);

      lblBarrasVarilla = barrasVarilla.toStringAsFixed(0);

      lblCostoMateriales =
          "\$ ${(costoMateriales + varios).toStringAsFixed(2)}";

      lblTotal = "\$ ${total.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 205, 199),

      appBar: AppBar(title: const Text("Calcular ventanas rombo")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [
            buildInput("Ancho ventana", txtAncho),

            buildInput("Alto ventana", txtAlto),

            buildInput("Separación", txtSeparacion),

            buildInput("Precio ángulo", txtPrecioAngulo),

            buildInput("Precio varilla", txtPrecioVarilla),

            buildInput("Valor varios", txtValorVarios),

            buildInput("Factor ganancia", txtFactorGanancia),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 45,

              child: ElevatedButton(
                onPressed: calcular,
                child: const Text("CALCULAR"),
              ),
            ),

            const SizedBox(height: 20),

            buildResult("Metros Ángulo", lblMetrosAngulo),

            buildResult("Barras Ángulo", lblBarrasAngulo),

            buildResult("Líneas", lblLineas),

            buildResult("Metros Varilla", lblMetrosVarilla),

            buildResult("Barras Varilla", lblBarrasVarilla),

            buildResult("Costo Materiales", lblCostoMateriales),

            buildResult("TOTAL", lblTotal, isTotal: true),
          ],
        ),
      ),
    );
  }

  /// INPUT
  Widget buildInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Row(
        children: [
          Expanded(child: Text(label)),

          SizedBox(
            width: 150,
            height: 50,

            child: TextField(
              controller: controller,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              textAlign: TextAlign.center,

              decoration: InputDecoration(
                filled: true,

                fillColor: const Color(0xFFEEF2FF),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// RESULTADO
  Widget buildResult(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: isTotal ? Colors.red : Colors.black,
              ),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 22 : 16,
              fontWeight: FontWeight.bold,
              color: isTotal ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
