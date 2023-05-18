import 'dart:math';

import 'package:flutter/material.dart';

import '../shared/mtp_constants.dart';

class MtpTools extends StatefulWidget {

  @override
  State<MtpTools> createState() => _MtpToolsState();
}

class _MtpToolsState extends State<MtpTools> {

  TextEditingController rentController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController houseMatesController = TextEditingController();

  TextEditingController loanAmountController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termsYrsController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final _morgFormKey = GlobalKey<FormState>();
  int toDisplayTool=1;

  @override
  Widget build(BuildContext context) {
    if(toDisplayTool==1){
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
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
                        child: Text(
                          "MTP Tools",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Ubuntu'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Palette.kToDark.shade800,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              child: Row(
                                children: [
                                  Text(
                                    "Rent Estimator",
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white70
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_right_alt_rounded,size: 40,color: Colors.white70,)
                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  toDisplayTool=2;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Palette.kToDark.shade800,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              child: Row(
                                children: [
                                  Text(
                                    "Mortgage Estimator",
                                    style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white70
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_right_alt_rounded,size: 40,color: Colors.white70,)
                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  toDisplayTool=3;
                                });
                              },
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    else if(toDisplayTool==2){
      return WillPopScope(
        onWillPop: () async{ return false; },
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
                        SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "MTP Tools",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Ubuntu'
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40,),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: (){
                                    setState(() {
                                      toDisplayTool=1;
                                    });
                                  }, icon: Icon(Icons.chevron_left,size: 40,)),
                                  SizedBox(width: 10,),
                                  Text(
                                      "Rent Calculator",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                  ),
                                ],
                              ),
                              Divider(
                                height: 35,
                                thickness: 1,
                                indent: 10,
                                endIndent: 0,
                                color: Palette.kToDark.shade800,
                              ),
                              SizedBox(height: 30,),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Monthly Rent",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (value){
                                        if(value==null || value.isEmpty){
                                          return "Please enter monthly rent";
                                        }
                                        return null;
                                      },
                                      controller: rentController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(),
                                        border: InputBorder.none,
                                        fillColor: Palette.kToDark.shade600,
                                        filled: true,
                                        hintText: "Monthly Rent",
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    const Text("Monthly Costs",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (value){
                                        if(value==null || value.isEmpty){
                                          return "Please enter monthly costs";
                                        }
                                        return null;
                                      },
                                      controller: costController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(),
                                        border: InputBorder.none,
                                        fillColor: Palette.kToDark.shade600,
                                        filled: true,
                                        hintText: "Monthly Costs",
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    const Text("No. of Housemates",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (value){
                                        if(value==null || value.isEmpty){
                                          return "This field cannot be blank";
                                        }
                                        return null;
                                      },
                                      controller: houseMatesController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(),
                                        border: InputBorder.none,
                                        fillColor: Palette.kToDark.shade600,
                                        filled: true,
                                        hintText: "Total housemates",
                                        hintStyle: const TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                    ),

                                    const SizedBox(height: 20,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Palette.kToDark.shade900,
                                        minimumSize: const Size.fromHeight(50), // NEW
                                      ),
                                      onPressed: (){
                                        int monthlyRent;
                                        int monthlyCost;
                                        int houseMates;
                                        int overallRent;
                                        if(_formKey.currentState!.validate()){
                                          setState(() {
                                            monthlyRent=int.parse(rentController.text);
                                            monthlyCost=int.parse(costController.text);
                                            houseMates=int.parse(rentController.text);

                                            overallRent=(monthlyRent+monthlyCost);
                                            print(overallRent);
                                            num rentPerPerson = (overallRent ~/ houseMates);
                                            print(rentPerPerson.toString());

                                            showCalculatorDialog(context, overallRent, rentPerPerson);
                                          });
                                        }

                                      },
                                      child: const Text(
                                        'Calculate',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )

                                  ],
                                ),
                              )


                            ],
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    else{
      return WillPopScope(
        onWillPop: () async{ return false; },
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
                        SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "MTP Tools",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Ubuntu'
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40,),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: (){
                                    setState(() {
                                      toDisplayTool=1;
                                    });
                                  }, icon: Icon(Icons.chevron_left,size: 40,)),
                                  SizedBox(width: 10,),
                                  Text(
                                      "Mortgage Calculator",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                  ),
                                ],
                              ),
                              Divider(
                                height: 35,
                                thickness: 1,
                                indent: 10,
                                endIndent: 0,
                                color: Palette.kToDark.shade800,
                              ),
                              SizedBox(height: 30,),
                              Form(
                                key: _morgFormKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Loan Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (value){
                                        if(value==null || value.isEmpty){
                                          return "Please enter loan amount";
                                        }
                                        return null;
                                      },
                                      controller: loanAmountController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(),
                                        border: InputBorder.none,
                                        fillColor: Palette.kToDark.shade600,
                                        filled: true,
                                        hintText: "Loan Amount",
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    const Text("Interest Rates",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (value){
                                        if(value==null || value.isEmpty){
                                          return "Please enter interest rate";
                                        }
                                        return null;
                                      },
                                      controller: interestRateController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(),
                                        border: InputBorder.none,
                                        fillColor: Palette.kToDark.shade600,
                                        filled: true,
                                        hintText: "Interest Rate",
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    const Text("Terms(yrs)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (value){
                                        if(value==null || value.isEmpty){
                                          return "This field cannot be blank";
                                        }
                                        return null;
                                      },
                                      controller: termsYrsController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(),
                                        border: InputBorder.none,
                                        fillColor: Palette.kToDark.shade600,
                                        filled: true,
                                        hintText: "Enter terms in years",
                                        hintStyle: const TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                    ),

                                    const SizedBox(height: 20,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Palette.kToDark.shade900,
                                        minimumSize: const Size.fromHeight(50), // NEW
                                      ),
                                      onPressed: (){
                                        double loanAmount;
                                        double interestRates;
                                        double termsInYears;
                                        if(_morgFormKey.currentState!.validate()){
                                          setState(() {
                                            loanAmount=double.parse(loanAmountController.text);
                                            interestRates=double.parse(interestRateController.text);
                                            termsInYears=double.parse(termsYrsController.text);

                                            int monthlyInterestRate=(interestRates ~/12) ~/100;
                                            double noOfMonths=(termsInYears*12);
                                            double? powerValue= pow((1+monthlyInterestRate), noOfMonths) as double?;

                                            double monthlyPayment=(monthlyInterestRate*powerValue!/(powerValue-1))*loanAmount;

                                            mortgageDialog(context, monthlyPayment);

                                          });
                                        }

                                      },
                                      child: const Text(
                                        'Calculate',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )

                                  ],
                                ),
                              )


                            ],
                          ),
                        )


                      ],
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

  showCalculatorDialog(BuildContext context, num totalrent, num perPerson) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Result",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 30,),
          Text("Overall Rent: "+totalrent.toString(),
            style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 10,),
          Text("Rent per person: "+perPerson.toString(),
            style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
      actions: [
        okButton
      ],
      scrollable: true,

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    rentController.clear();
    costController.clear();
    houseMatesController.clear();
  }
  mortgageDialog(BuildContext context, num monthlyPayment) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Result",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 30,),
          Text("Overall Rent: "+monthlyPayment.toString(),
            style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
      actions: [
        okButton
      ],
      scrollable: true,

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    loanAmountController.clear();
    interestRateController.clear();
    termsYrsController.clear();
  }


}
