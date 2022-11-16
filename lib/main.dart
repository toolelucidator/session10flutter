import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'student.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'database_operations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Student>>? Studentss;
  TextEditingController controller = TextEditingController();
  TextEditingController APEPAcontroller = TextEditingController();
  TextEditingController APEMAcontroller = TextEditingController();
  TextEditingController TELcontroller = TextEditingController();
  TextEditingController EMAILcontroller = TextEditingController();
  String? name;
  String? apepa;
  String? apema;
  String? tel;
  String? email;
  int? curUserId;

  final formKey = new GlobalKey<FormState>();
  late var dbHelper;
  late bool isUpdating;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  //Métodos auxiliares

  refreshList() {
    //Cargar con un select
    setState(() {
      Studentss = dbHelper.getStudentss();
    });
  }

  clearName() {
    //Limpiar el campo de texto
    controller.text = '';
  }

  //Validar formulario
  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isUpdating) {
        Student e = Student(curUserId, name, apepa, apema, tel, email);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Student e = Student(null, name, apepa, apema, tel, email);
        dbHelper.save(e);
      }
      clearName();
      refreshList();
    }
  }

  double getNumberofRecords(double n_elements) {
    double sizemultiplier = 0;

    return sizemultiplier;
  }

  Widget form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nombre",
              ),
              validator: (val) => val!.length == 0 ? 'Ingrese Nombre' : null,
              onSaved: (val) => name = val,
            ),
            TextFormField(
              controller: APEPAcontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Apellido Paterno ",
              ),
              validator: (val) => val!.length == 0 ? 'Apellido Paterno' : null,
              onSaved: (val) => apepa = val,
            ),
            TextFormField(
              controller: APEMAcontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Apellido Materno ",
              ),
              validator: (val) => val!.length == 0 ? 'Apellido Materno' : null,
              onSaved: (val) => apema = val,
            ),
            TextFormField(
              controller: TELcontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Telefono",
              ),
              validator: (val) => val!.length == 0 ? 'Telefono' : null,
              onSaved: (val) => tel = val,
            ),
            TextFormField(
              controller: EMAILcontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "E-Mail ",
              ),
              validator: (val) => val!.length == 0 ? 'E-Mail' : null,
              onSaved: (val) => email = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: validate,
                  child: Text(isUpdating ? 'Actualizar' : 'Agregar'),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('Cancelar'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //Scrollview

  SingleChildScrollView dataTable(List<Student>? Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('AM')),
          DataColumn(label: Text('AP')),
          DataColumn(label: Text('Tel')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Borrar')),
        ],
        rows: Studentss!.map((mapStudent) => DataRow(cells: [
              DataCell(
                Text(mapStudent.name!),
                onTap: () {
                  setState(() {
                    isUpdating = true;
                    curUserId = mapStudent.controlnum;
                  });
                  controller.text = mapStudent.name!;
                },
              ),
              DataCell(
                Text(mapStudent.apepa!),
                /*onTap: () {
              setState(() {
                isUpdating = true;
                curUserId = mapStudent.controlnum;
              });
              controller.text = mapStudent.name;
            },*/
              ),
              DataCell(
                Text(mapStudent.apema!),
                /*onTap: () {
              setState(() {
                isUpdating = true;
                curUserId = mapStudent.controlnum;
              });
              controller.text = mapStudent.name;
            },*/
              ),
              DataCell(
                Text(mapStudent.tel!),
                /*onTap: () {
              setState(() {
                isUpdating = true;
                curUserId = mapStudent.controlnum;
              });
              controller.text = mapStudent.name;
            },*/
              ),
              DataCell(
                Text(mapStudent.email!),
                /*onTap: () {
              setState(() {
                isUpdating = true;
                curUserId = mapStudent.controlnum;
              });
              controller.text = mapStudent.name;
            },*/
              ),
              DataCell(
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(mapStudent.controlnum);
                      refreshList();
                    }),
              )
            ])).toList(),
      ),
    );
  }

  //Vista principal
  Widget list() {
    return Expanded(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: Studentss,
            builder: (context,  AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return dataTable(snapshot.data);
              }
              if (null == snapshot.hasData) {
                print("Data not found");
                return Text("Data not Found");
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Sqlite basic operations"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [
          form(),
          list(),
        ],
      ),
    );
  }
}
