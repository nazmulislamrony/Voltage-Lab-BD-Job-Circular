import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:voltage_lab_bd_job_circular/model/pdf_model.dart';
class Pdf_Provider extends ChangeNotifier{

  pdfMoled_class _PDf_model=pdfMoled_class();
  List<pdfMoled_class> _Pdf_productlist=[];
  pdfMoled_class get pdf_model => _PDf_model;
  List<pdfMoled_class> get CategoryList => _Pdf_productlist;

  String? _loadingMgs;
  String get loadingMgs => _loadingMgs!;

  set Ecommerce_model(pdfMoled_class value) {
    _PDf_model = value;
    notifyListeners();
  }

  set loadingMgs(String val) {
    _loadingMgs = val;
    notifyListeners();
  }


  Future<void> getCategory(
      String collection,
      ) async {
    try {
      await FirebaseFirestore.instance.collection(collection)
          .get()
          .then((snapShot) {
        _Pdf_productlist.clear();
        print("Length: " + _Pdf_productlist.length.toString());
        snapShot.docChanges.forEach((element) {

          pdfMoled_class productModels = pdfMoled_class(
            url:element.doc['url'],
              name:element.doc['name'],
          );
          _Pdf_productlist.add(productModels);
        });

      });
      print("Length: " + _Pdf_productlist.length.toString());
      notifyListeners();
    } catch (error) {
      error.toString();
    }
  }

}