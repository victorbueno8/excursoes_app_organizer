import 'package:flutter/material.dart';
import 'package:excursoes_app_organizer/model/excursion.dart';
import 'package:excursoes_app_organizer/util/dbhelper.dart';

class ExcursionList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExcursionListState();
}

class ExcursionListState extends State<ExcursionList> {
  DbHelper helper = DbHelper();
  List<Excursion> excursions;
  int count = 0;

  void getData() {
    final dbFuture = helper.initializeDb();

    dbFuture.then( (result) {
      final excursionFuture = helper.getExcursions();
      excursionFuture.then((result) {
        List<Excursion> excursionList = List<Excursion>();
        count = result.length;
        for (int i = 0; i < count; i++) {
          excursionList.add(Excursion.fromObject(result[i]));
          debugPrint(excursionList[i].title);
        }
        setState(() {
          excursions = excursionList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (excursions == null) {
       excursions = List<Excursion>();
       getData();
     }

    return Scaffold(
      body: excursionListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: "Add new Todo",
        child: new Icon(Icons.add),
      ),
    );
  }

  ListView excursionListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.excursions[position].date),
              child: Text(this.excursions[position].date.toString()),
            ),
            title: Text(this.excursions[position].title),
            subtitle: Text(this.excursions[position].date),
            onTap: () {
              debugPrint(
                  "Tapped on " + this.excursions[position].id.toString());
            },
          ),
        );
      },
    );
  }

  Color getColor(String date) {
    if(date == DateTime.now().toString()) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}

