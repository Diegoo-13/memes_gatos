import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: GeneradorMemesGatos(),
    debugShowCheckedModeBanner: false,
  ));
}

class GeneradorMemesGatos extends StatefulWidget {
  const GeneradorMemesGatos({super.key});

  @override
  State<GeneradorMemesGatos> createState() => _GeneradorMemesGatosState();
}

class _GeneradorMemesGatosState extends State<GeneradorMemesGatos> {
  final _controller = TextEditingController(text: 'Examen de Flutter');
  String _urlImagen = 'https://cataas.com/cat/says/Examen%20de%20Flutter';

  void _generarMeme() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;
    
    final textoCodificado = Uri.encodeComponent(texto);
    // El timestamp (?t=...) al final evita que Flutter guarde la imagen anterior en caché
    setState(() {
      _urlImagen = 'https://cataas.com/cat/says/$textoCodificado?t=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🐱 Generador de Memes de Gatos'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Frase para el gato',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: _generarMeme,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generar Meme'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _urlImagen,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Text('Error al cargar la imagen 😿'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}