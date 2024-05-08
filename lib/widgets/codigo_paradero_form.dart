import 'package:flutter/material.dart';
import 'package:mibus/services/api_service.dart'; // Importa el servicio de la API
import 'package:mibus/models/paradero_model.dart'; // Importa la clase de modelo Paradero
import 'package:mibus/screens/paradero_info_screen.dart'; // Importa la ventana ParaderoInfo

class CodigoParaderoForm extends StatefulWidget {
  final void Function(String) onSubmit;

  CodigoParaderoForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _CodigoParaderoFormState createState() => _CodigoParaderoFormState();
}

class _CodigoParaderoFormState extends State<CodigoParaderoForm> {
  final TextEditingController _codigoController = TextEditingController();
  bool _isLoading = false;

  Future<void> _enviarCodigo(BuildContext context, String codigo) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final jsonResponse = await ApiService.obtenerDatosParadero(codigo);
      final paradero = Paradero.fromJson(jsonResponse);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParaderoInfo(paradero: paradero),
        ),
      );
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 260,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingrese el código de paradero:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _codigoController,
              decoration: InputDecoration(
                hintText: 'Buscar paradero',
                filled: true,
                fillColor: Colors.blueGrey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20.0),
            _isLoading
                ? CircularProgressIndicator() // Muestra el loader si isLoading es true
                : Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        widget.onSubmit(_codigoController.text);
                        _enviarCodigo(context, _codigoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      child: Text(
                        'Buscar'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}