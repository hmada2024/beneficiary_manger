import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/beneficiary_controller.dart';
import '../models/beneficiary.dart';

class BeneficiaryScreen extends StatelessWidget {
  final Beneficiary? beneficiary;
  final nameController = TextEditingController();
  final familySizeController = TextEditingController();
  final cardNumberController = TextEditingController();
  final breadCountController = TextEditingController();
  final BeneficiaryController beneficiaryController = Get.find();

  final _formKey = GlobalKey<FormState>();

  BeneficiaryScreen({super.key, this.beneficiary}) {
    if (beneficiary != null) {
      nameController.text = beneficiary!.name;
      familySizeController.text = beneficiary!.familySize.toString();
      cardNumberController.text = beneficiary!.cardNumber;
      breadCountController.text = beneficiary!.breadCount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beneficiary == null ? 'إضافة مستفيد' : 'تعديل مستفيد'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                  labelStyle: TextStyle(color: Colors.teal),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'الاسم يجب أن يحتوي على حروف فقط';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: familySizeController,
                decoration: const InputDecoration(
                  labelText: 'عدد أفراد الأسرة',
                  labelStyle: TextStyle(color: Colors.teal),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال عدد أفراد الأسرة';
                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'عدد أفراد الأسرة يجب أن يكون رقماً';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'رقم البطاقة',
                  labelStyle: TextStyle(color: Colors.teal),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              TextFormField(
                controller: breadCountController,
                decoration: const InputDecoration(
                  labelText: 'عدد الأرغفة المطلوبة',
                  labelStyle: TextStyle(color: Colors.teal),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال عدد الأرغفة المطلوبة';
                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'عدد الأرغفة يجب أن يكون رقماً';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: Text(beneficiary == null ? 'إضافة' : 'تحديث'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (beneficiary == null) {
                      beneficiaryController.addBeneficiary(Beneficiary(
                        name: nameController.text,
                        familySize: int.parse(familySizeController.text),
                        cardNumber: cardNumberController.text,
                        breadCount: int.parse(breadCountController.text),
                      ));
                    } else {
                      beneficiaryController.updateBeneficiary(Beneficiary(
                        id: beneficiary!.id,
                        name: nameController.text,
                        familySize: int.parse(familySizeController.text),
                        cardNumber: cardNumberController.text,
                        breadCount: int.parse(breadCountController.text),
                      ));
                    }
                    Get.back();
                  }
                },
              ),
              if (beneficiary != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    beneficiaryController.deleteBeneficiary(beneficiary!.id!);
                    Get.back();
                  },
                  child: const Text('حذف'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
