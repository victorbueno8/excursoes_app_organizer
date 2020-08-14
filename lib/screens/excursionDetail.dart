import 'package:flutter/material.dart';
import 'package:excursoes_app_organizer/util/dbhelper.dart';
import 'package:excursoes_app_organizer/model/excursion.dart';
import 'package:intl/intl.dart';

final List<String> choices = const <String> [
  'Salvar Excursão',
  'Remover Excursão'
];
const mnuSave = 'Salvar Excursão';
const mnuDelete = 'Remover Excursão';

class ExcursionDetail extends StatefulWidget {
  final Excursion excursion;

  ExcursionDetail(this.excursion);

  @override
  State<StatefulWidget> createState() => ExcursionDetailState(excursion);
}



class ExcursionDetailState extends State<ExcursionDetail> {
  Excursion excursion;
  DbHelper helper = DbHelper();

  ExcursionDetailState(this.excursion);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.parse(excursion.date),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null)
        setState(() {
          excursion.date = picked.toString();
        });
    }

    titleController.text = excursion.title;
    descriptionController.text = excursion.description;
    localController.text = excursion.local;
    dateController.text = excursion.date;
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    void updateTitle(){
      excursion.title = titleController.text;
    }
    void updateDescription() {
      excursion.description = descriptionController.text;
    }
    void updateLocal(){
      excursion.local = localController.text;
    }
    void updateDate() {
      excursion.date = dateController.text;
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(excursion.title),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) => updateTitle(),
                decoration: InputDecoration(
                  labelText: "Título",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) => updateDescription(),
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: localController,
                  style: textStyle,
                  onChanged: (value) => updateLocal(),
                  decoration: InputDecoration(
                    labelText: "Local",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: dateController,
                  style: textStyle,
                  onChanged: (value) => updateDate(),
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    labelText: "Data",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  void select(String value) async {
    int result;

    switch(value) {
      case mnuSave:
        save();
        break;

      case mnuDelete:
        Navigator.pop(context, true);
        if(excursion.id == null) {
          return;
        }
        result = await helper.deleteExcursion(excursion.id);
        if(result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Deletar Excursão"),
            content: Text("A Excursão foi deletada"),
          );
          showDialog(context: context, builder: (context) => alertDialog);
        }
        break;

      default:
    }
  }

  void save() {
    if(excursion.id != null) {
      helper.updateExcursion(excursion);
    } else {
      helper.insertExcursion(excursion);
    }
    Navigator.pop(context, true);
  }

}