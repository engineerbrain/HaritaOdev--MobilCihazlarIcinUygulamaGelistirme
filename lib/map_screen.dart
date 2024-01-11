import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Set<Polygon> polygons = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harita'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        polygons: polygons,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Haritanın merkezi
          zoom: 15,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewRecordDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNewRecordDialog() {
    // Yeni kayıt eklemek için bir dialog göster
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Kayıt Ekle'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Bina Adı'),
                // Bina adını saklamak için bir değişken ekleyin
              ),
              DropdownButtonFormField<String>(
                value: 'Hafif', // Default değer
                items: ['Hafif', 'Orta', 'Ağır']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  // Hasar durumu seçimini saklamak için bir değişken ekleyin
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Kaydı Firebase'e eklemek ve haritada göstermek için gerekli işlemleri yapın
                  Navigator.pop(context); // Dialogu kapat
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addNewRecord(
      String buildingName, String damageLevel, List<LatLng> points) {
    // Firebase'e kaydet
    // ...

    // Polygon oluştur ve haritaya ekle
    setState(() {
      Polygon polygon = Polygon(
        polygonId: PolygonId(buildingName),
        points: points,
        fillColor: _getFillColor(damageLevel),
        strokeColor: Colors.black,
        strokeWidth: 2,
      );
      polygons.add(polygon);
    });
  }

  Color _getFillColor(String damageLevel) {
    switch (damageLevel) {
      case 'Ağır':
        return Colors.red;
      case 'Orta':
        return Colors.orange;
      case 'Hafif':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }
}
