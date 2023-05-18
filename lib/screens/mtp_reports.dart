import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mypropertyuk/models/get_expenses_model.dart';
import 'package:mypropertyuk/shared/loading.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../shared/ApiConstants.dart';
import '../shared/loading_small.dart';
import '../shared/mtp_constants.dart';
class MtpReports extends StatefulWidget {
  const MtpReports({Key? key}) : super(key: key);

  @override
  State<MtpReports> createState() => _MtpReportsState();
}
String logedInusername="";
String logedInuseremail="";
String logedInuserid="";
int currentMonth = DateTime.now().month;
int currentYear=DateTime.now().year;

DateTime costDate=new DateTime.now();

String expDate="";



class _MtpReportsState extends State<MtpReports> {



  @override
  void initState() {
    getUserPrefrences().whenComplete(() => getAllExpensesByuserId());
    super.initState();

  }

  Future getUserPrefrences() async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String username=sharedPreferences.getString("user_name").toString();
    String useremail=sharedPreferences.getString("user_email").toString();
    String userid=sharedPreferences.getString("user_id").toString();

    setState(() {
      logedInuseremail=useremail;
      logedInusername=username;
      logedInuserid=userid;
    });
  }

  Future<List<GetExpensesModel>> getAllExpensesByuserId() async{

    var url=Uri.parse(ApiConstants.BASE_URL+"getExpenses.php");
    var response=await http.post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName("utf-8"),
        body: {
          "user_id":"$logedInuserid",
          "month":"$currentMonth",
          "year":"$currentYear",
        }
    );

    var data = jsonDecode(response.body);
    List userExp = data["data"];
    return userExp.map((data) => new GetExpensesModel.fromJson(data)).toList();
  }

  List<String> monthList=[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  int toViewPage=1;
  final _addExpKey = GlobalKey<FormState>();
  TextEditingController expNameController=new TextEditingController();
  TextEditingController expCostController=new TextEditingController();
  bool isExpenseLoading=false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    if(toViewPage==2){
      return isExpenseLoading==false ? WillPopScope(
        child: Scaffold(
          backgroundColor: Palette.kToDark.shade100,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                              setState(() {
                                toViewPage=1;
                              });
                            }, icon: Icon(Icons.chevron_left,size: 40,)),
                            const Text(
                              "Add New Expense",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Ubuntu'
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  key:_addExpKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20,),
                                      const Text("Expense Name",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Ubuntu'
                                        ),
                                      ),
                                      const SizedBox(height: 8,),
                                      TextFormField(
                                        controller: expNameController,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (value){
                                          if(value==null || value.isEmpty){
                                            return "Expense name cannot be blank";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: const OutlineInputBorder(),
                                          border: InputBorder.none,
                                          fillColor: Palette.kToDark.shade600,
                                          filled: true,
                                          hintText: "Ex. Renovation, Repairs, etc.",
                                          hintStyle: const TextStyle(
                                              fontStyle: FontStyle.italic
                                          ),
                                          contentPadding: const EdgeInsets.all(18.0),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      const Text("Cost",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Ubuntu'
                                        ),
                                      ),
                                      const SizedBox(height: 8,),
                                      TextFormField(
                                        controller: expCostController,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value){
                                          if(value==null || value.isEmpty){
                                            return "Cost cannot be blank";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: const OutlineInputBorder(),
                                          border: InputBorder.none,
                                          fillColor: Palette.kToDark.shade600,
                                          filled: true,
                                          hintText: "Ex. 30000",
                                          hintStyle: const TextStyle(
                                              fontStyle: FontStyle.italic
                                          ),
                                          contentPadding: const EdgeInsets.all(18.0),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      const Text("Select Date",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Ubuntu'
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        children: [
                                          Text(
                                              expDate,
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic
                                          ),
                                          ),
                                          SizedBox(width: 30,),
                                          ElevatedButton(
                                            onPressed: () async {
                                              final newDate= await showDatePicker(context: context,
                                                  initialDate: costDate,
                                                  firstDate: DateTime(DateTime.now().year - 5),
                                                  lastDate: DateTime(DateTime.now().year + 5));
                                              if(newDate == null) return;
                                              setState(() {
                                                expDate=DateFormat('MM-dd-yyyy').format(newDate);
                                              });
                                            },
                                            child: const Text(
                                              "Select Date",
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Palette.kToDark.shade800
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20,)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Palette.kToDark.shade800,
                                    minimumSize: const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () async {
                                  if(_addExpKey.currentState!.validate()){
                                    setState(() {
                                      isExpenseLoading=true;
                                    });
                                    String expenseName=expNameController.text;
                                    String expenseCost=expCostController.text;

                                    var response = await addNewExpense(expenseName, expenseCost);
                                    if(response!=null && response["code"]==201){
                                      setState(() {
                                        isExpenseLoading=false;
                                        expNameController.clear();
                                        expCostController.clear();

                                        Toast.show("New Expense Added!", gravity: Toast.center, duration: Toast.lengthLong);
                                        Timer(const Duration(seconds: 1),
                                                (){
                                              setState(() {
                                                toViewPage=1;
                                              });

                                            });
                                      });
                                    }
                                    else{
                                      setState(() {
                                        isExpenseLoading=false;
                                        print(response);
                                        Toast.show("Something went wrong, Please try again", gravity: Toast.center, duration: Toast.lengthLong);
                                      });
                                    }

                                  }
                                  },
                                  child: const Text(
                                    'Add New Expense',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onWillPop: () async{return false;},
      ) : Loading();
    }
    else{
      return Scaffold(
        backgroundColor: Palette.kToDark.shade100,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Expense Reports",
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Ubuntu'
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: (){
                                      showYearPicker();
                                    },
                                    child: const Text(
                                      "Select Year",
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Palette.kToDark.shade800
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  ElevatedButton(
                                    onPressed: (){
                                      showMonthPicker();
                                    },
                                    child: const Text(
                                      "Select Month",
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Palette.kToDark.shade800
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text(monthName(currentMonth)+", ",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Ubuntu'
                                    ),
                                  ),
                                  Text(currentYear.toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Ubuntu'
                                    ),)
                                ],
                              ),
                              Divider(
                                color: Palette.kToDark.shade900,
                              ),
                              SizedBox(height: 10,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Palette.kToDark.shade800,
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                                onPressed: (){
                                  setState(() {
                                    toViewPage=2;
                                  });
                                },
                                child: const Text(
                                  'Add New Expense',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              SizedBox(height: 5,),
                              FutureBuilder<List<GetExpensesModel>>(
                                  future: getAllExpensesByuserId(),
                                  builder: (context,snapshot){
                                    if(snapshot.hasData){
                                      return
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, i){
                                            return Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(snapshot.data![i].expenseName,
                                                        style: TextStyle(
                                                            fontSize: 21,
                                                            fontFamily: 'Ubuntu',
                                                            fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                      Text(DateFormat('MM-dd-yyyy').format(snapshot.data![i].date),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: 'Ubuntu',
                                                            fontWeight: FontWeight.w100
                                                        ),
                                                      ),
                                                      SizedBox(height: 8,),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Text("£"+snapshot.data![i].cost,
                                                    style: TextStyle(
                                                        fontSize: 21,
                                                        fontFamily: 'Ubuntu',
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                    }
                                    else if(snapshot.hasError){
                                      return Container(
                                        child: Text("No expenses recorded for this month"),
                                      );
                                    }
                                    return LoadingSmall();
                                  }
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  String monthName(int num){

    String monthName="";

    switch(num){
      case 1: {monthName="Jan";}break;
      case 2: {monthName="Feb";}break;
      case 3: {monthName="Mar";}break;
      case 4: {monthName="Apr";}break;
      case 5: {monthName="May";}break;
      case 6: {monthName="June";}break;
      case 7: {monthName="July";}break;
      case 8: {monthName="Aug";}break;
      case 9: {monthName="Sep";}break;
      case 10: {monthName="Oct";}break;
      case 11: {monthName="Nov";}break;
      case 12: {monthName="Dec";}break;
    }
    return monthName;
  }

  showYearPicker(){
    AlertDialog alertDialog=AlertDialog(
      title: Text("Select Year"),
      content: Container( // Need to use container to add size constraint.
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 100, 1),
          lastDate: DateTime(DateTime.now().year + 100, 1),
          initialDate: DateTime.now(),
          // save the selected date to _selectedDate DateTime variable.
          // It's used to set the previous selected date when
          // re-showing the dialog.
          onChanged: (DateTime dateTime) {
            // close the dialog when year is selected.
            Navigator.pop(context);
            setState(() {
              currentYear=dateTime.year;
              getAllExpensesByuserId();
            });

            // Do something with the dateTime selected.
            // Remember that you need to use dateTime.year to get the year
          }, selectedDate: DateTime.now(),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
  showMonthPicker(){
    AlertDialog alertDialog=AlertDialog(
      title: Text("Select Month"),
      content: Container( // Need to use container to add size constraint.
        width: 300,
        height: 400,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return ChoiceChip(
              label: Text(monthName(index+1)),
              padding: EdgeInsets.all(16),
              selected: true,
              selectedColor: Palette.kToDark.shade200,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onSelected: (bool selected) {
                setState(() {
                  currentMonth=index+1;
                  Navigator.pop(context);
                  getAllExpensesByuserId();
                });
              },
            );
          },
        )
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }


  Future addNewExpense(String expense_name, String exp_cost) async {

    var url=Uri.parse(ApiConstants.BASE_URL+"addExpenses.php");
    var response=await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName("utf-8"),
      body:{
        "user_id":"$logedInuserid",
        "expense_name":"$expense_name",
        "cost":"$exp_cost",
        "date":"$expDate",
    }
    );

    var data=json.decode(response.body);

    if(data["code"]==201){
      String responseString=response.body;
      print(responseString);
    }
    return data;

  }

}
