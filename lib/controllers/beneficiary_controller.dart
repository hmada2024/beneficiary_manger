import 'package:get/get.dart';
import '../models/beneficiary.dart';
import '../database/database_helper.dart';

class BeneficiaryController extends GetxController {
  var beneficiaries = <Beneficiary>[].obs;

  @override
  void onInit() {
    fetchBeneficiaries();
    super.onInit();
  }

  Future<void> fetchBeneficiaries() async {
    final dataList = await DatabaseHelper().queryAllBeneficiaries();
    beneficiaries.value = dataList.map((item) => Beneficiary.fromMap(item)).toList();
  }

  Future<void> addBeneficiary(Beneficiary beneficiary) async {
    await DatabaseHelper().insertBeneficiary(beneficiary.toMap());
    fetchBeneficiaries();
  }

  Future<void> updateBeneficiary(Beneficiary beneficiary) async {
    await DatabaseHelper().updateBeneficiary(beneficiary.toMap());
    fetchBeneficiaries();
  }

  Future<void> deleteBeneficiary(int id) async {
    await DatabaseHelper().deleteBeneficiary(id);
    fetchBeneficiaries();
  }
}
