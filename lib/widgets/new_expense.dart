import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget{

  const NewExpense({super.key,required this.addExpense});
  final void Function (Expense) addExpense;
  
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }

}

class _NewExpenseState extends State<NewExpense>{
  // var _enteredTitle = "";

  // void _saveTitle(String title){
  //   _enteredTitle = title;
  // }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose(){
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async 
  {
     final pickedDate = await showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2021), 
    lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day));
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData()
  {
    final entered_amount = double.tryParse(_amountController.text);
    final amountIsInvalid = entered_amount==null || entered_amount<=0;
    if(_titleController.text.trim().isEmpty ||
     amountIsInvalid || 
     _selectedDate ==null)
    {
      showDialog(context: context, builder: (ctx){
        return AlertDialog(
          title: const Text("Invalid input"),
          content: const Text("Please enter valid input"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Okay"))
          ],
        );
      });
      return;
    }
    Navigator.pop(context);
    widget.addExpense(Expense(
      title: _titleController.text,
      amount: entered_amount,
      date: _selectedDate!,
      category: _selectedCategory
    ));
    //adding the expenses in the list
  }

  @override
  Widget build(BuildContext context) {
   return (
    Padding(padding: EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: InputDecoration(
            label : const Text("Title"),
          ),
        ),
        Row(children: [
          Expanded(
            child: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: "\$",
              label : const Text("Amount"),
            ),
                    ),
          ),
        const SizedBox(width: 16,),
        Expanded(child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_selectedDate==null?"No date selected" : dateFormat.format(_selectedDate!)),
            IconButton(onPressed: (){
              _presentDatePicker();
            }, icon: const Icon(Icons.calendar_month),),
          ],
        ))
        ],),
        SizedBox(height: 16,),
        
        Row(children: [
          DropdownButton(
            value: _selectedCategory,
            items: Category.values.map(
            (category)=>DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase(),))
            ).toList(), 
            onChanged: (value){
              if(value==null)
              return;
              setState(() 
              {
                 _selectedCategory = value as Category;
              });
            }),
            Spacer(),
            TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel")),

          ElevatedButton(onPressed: (){
            _submitExpenseData();
            // print(_titleController.text);
            // print(_amountController.text);
          }, child: const Text("Save expense")),
          
        ],)
      ],
    ),)
   );
  }
  
}