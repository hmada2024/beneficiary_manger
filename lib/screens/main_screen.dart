import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/beneficiary_controller.dart';
import 'beneficiary_screen.dart';

class MainScreen extends StatelessWidget {
  final BeneficiaryController beneficiaryController = Get.put(BeneficiaryController());

   MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة بيانات المستفيدين للمخبز'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: beneficiaryController.beneficiaries.length,
          itemBuilder: (context, index) {
            final beneficiary = beneficiaryController.beneficiaries[index];
            return ListTile(
              title: Text(beneficiary.name),
              subtitle: Text('عدد أفراد الأسرة: ${beneficiary.familySize}'),
              trailing: Text('أرغفة: ${beneficiary.breadCount}'),
              onTap: () {
                Get.to(() => BeneficiaryScreen(beneficiary: beneficiary));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => BeneficiaryScreen());
        },
      ),
    );
  }
}
