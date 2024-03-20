
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../controllers/filter_container_controller.dart';
import '../models/filters.dart';
import '../services/filters_service.dart';
import '../controllers/filter_controller.dart';

class FiltersView extends StatefulWidget {
  const FiltersView({Key? key}) : super(key: key);

  @override
  _FiltersViewState createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  late Future<List<Modelo>> _futureModelos;
  late Future<List<Marca>> _futureMarcas;
  late Future<List<Color>> _futureColores;
  late Future<List<Talla>> _futureTallas;

  final FilterController _filtersController = Get.put(FilterController());
  final FilterController _filterGetController = Get.find<FilterController>();

  @override
  void initState() {
    super.initState();
    _futureModelos = FilterService.fetchModelo();
    _futureMarcas = FilterService.fetchMarca();
    _futureColores = FilterService.fetchColor();
    _futureTallas = FilterService.fetchTalla();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Modelo'),
            getModel(_futureModelos, _filtersController, _filterGetController),
            Divider(color: Colors.white,),
            Text('Marca'),
            getMarca(_futureMarcas, _filtersController, _filterGetController),
            Divider(color: Colors.white,),
            Text('Color'),
            getColor(_futureColores, _filtersController, _filterGetController),
            Divider(color: Colors.white,),
            Text('Talla'),
            getTalla(_futureTallas, _filtersController, _filterGetController),
            Divider(color: Colors.white,),
            Divider(color: Colors.white,),
            ElevatedButton(

              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setBool('is_filter', true);
                  Navigator.pop(context, true);
                });
              },
              child: Text('Apply Filter'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getModel(Future<List<Modelo>> _futureModelos, FilterController controller, FilterController filterGetController){
  return Center(
      child:
      FutureBuilder<List<Modelo>>(
        future: _futureModelos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Modelo> modelos = snapshot.data!;
            controller.setSelectedModelName('-');

            return Obx(() => DropdownButton<String>(
              value: controller.selectedModelName.value,
              items: [
                DropdownMenuItem<String>(
                  value: '-', // Establecer el valor "-" aquí
                  child: Text('-'), // Texto para mostrar en el DropdownMenuItem
                ),
                ...modelos.map((modelo) {
                  return DropdownMenuItem<String>(
                    value: modelo.name,
                    child: Text(modelo.name),
                  );
                }).toList(),
              ],
              onChanged: (String? selectedModelName) {
                Modelo? selectedModel;
                try {
                  selectedModel = modelos.firstWhere((model) => model.name == selectedModelName);
                } catch (e) {
                  selectedModel = null;
                }
                if (selectedModel != null) {
                  controller.setSelectedModelName(selectedModel.name ?? '');
                  print(selectedModel.id);
                  print(selectedModel.name);
                  SharedPreferences.getInstance().then((prefs) {
                    // Borrar el valor anterior
                    prefs.remove('idModelo');
                    prefs.setString('idModelo', '${selectedModel!.id}');
                  });
                }
              },
            ));
          }
        },
      )
  );
}


Widget getMarca(Future<List<Marca>> _futureModelos, FilterController controller, FilterController filterGetController){
  return Center(
      child:
      FutureBuilder<List<Marca>>(
        future: _futureModelos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Marca> modelos = snapshot.data!;
            controller.setSelectedMarcaName('-');

            return Obx(() => DropdownButton<String>(
              value: controller.selectedMarcaName.value,
              items: [
                DropdownMenuItem<String>(
                  value: '-', // Establecer el valor "-" aquí
                  child: Text('-'), // Texto para mostrar en el DropdownMenuItem
                ),
                ...modelos.map((modelo) {
                  return DropdownMenuItem<String>(
                    value: modelo.name,
                    child: Text(modelo.name),
                  );
                }).toList(),
              ],
              onChanged: (String? selectedModelName) {
                Marca? selectedModel;
                try {
                  selectedModel = modelos.firstWhere((model) => model.name == selectedModelName);
                } catch (e) {
                  selectedModel = null;
                }
                if (selectedModel != null) {
                  controller.setSelectedMarcaName(selectedModel.name ?? '');
                  print(selectedModel.id);
                  print(selectedModel.name);
                  SharedPreferences.getInstance().then((prefs) {
                    // Borrar el valor anterior
                    prefs.remove('idMarca');
                    prefs.setString('idMarca', '${selectedModel!.id}');
                  });
                }
              },
            ));
          }
        },
      )
  );
}

Widget getColor(Future<List<Color>> _futureModelos, FilterController controller, FilterController filterGetController){
  return Center(
      child:
      FutureBuilder<List<Color>>(
        future: _futureModelos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Color> modelos = snapshot.data!;
            controller.setSelectedColorName('-');

            return Obx(() => DropdownButton<String>(
              value: controller.selectedColorName.value,
              items: [
                DropdownMenuItem<String>(
                  value: '-', // Establecer el valor "-" aquí
                  child: Text('-'), // Texto para mostrar en el DropdownMenuItem
                ),
                ...modelos.map((modelo) {
                  return DropdownMenuItem<String>(
                    value: modelo.name,
                    child: Text(modelo.name),
                  );
                }).toList(),
              ],
              onChanged: (String? selectedModelName) {
                Color? selectedModel;
                try {
                  selectedModel = modelos.firstWhere((model) => model.name == selectedModelName);
                } catch (e) {
                  selectedModel = null;
                }
                if (selectedModel != null) {
                  controller.setSelectedColorName(selectedModel.name ?? '');
                  print(selectedModel.id);
                  print(selectedModel.name);
                  SharedPreferences.getInstance().then((prefs) {
                    // Borrar el valor anterior
                    prefs.remove('idColor');
                    prefs.setString('idColor', '${selectedModel!.id}');
                  });
                }
              },
            ));
          }
        },
      )
  );
}


Widget getTalla(Future<List<Talla>> _futureModelos, FilterController controller, FilterController filterGetController){
  return Center(
      child:
      FutureBuilder<List<Talla>>(
        future: _futureModelos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Talla> modelos = snapshot.data!;
            controller.setSelectedTallaName('-');

            return Obx(() => DropdownButton<String>(
              value: controller.selectedTallaName.value,
              items: [
                DropdownMenuItem<String>(
                  value: '-', // Establecer el valor "-" aquí
                  child: Text('-'), // Texto para mostrar en el DropdownMenuItem
                ),
                ...modelos.map((talla) {
                  return DropdownMenuItem<String>(
                    value: talla.name,
                    child: Text(talla.name),
                  );
                }).toList(),
              ],
              onChanged: (String? selectedModelName) {
                Talla? selectedModel;
                try {
                  selectedModel = modelos.firstWhere((model) => model.name == selectedModelName);
                } catch (e) {
                  selectedModel = null;
                }
                if (selectedModel != null) {
                  controller.setSelectedTallaName(selectedModel.name ?? '');
                  print(selectedModel.id);
                  print(selectedModel.name);
                  SharedPreferences.getInstance().then((prefs) {
                    // Borrar el valor anterior
                    prefs.remove('idTalla');
                    prefs.setString('idTalla', '${selectedModel!.id}');
                  });
                }
              },
            ));
          }
        },
      )
  );
}