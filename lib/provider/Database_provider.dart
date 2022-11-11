import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:voltage_lab_bd_job_circular/model/pdf_model.dart';
class Pdf_Provider extends ChangeNotifier{

  pdfMoled_class _PDf_model=pdfMoled_class();
  List<pdfMoled_class> _Pdf_productlist=[];
  List<pdfMoled_class> sub_Pdf_productlist=[];
  pdfMoled_class get pdf_model => _PDf_model;
  List<pdfMoled_class> get CategoryList => _Pdf_productlist;
  List<pdfMoled_class> get subCategoryList => sub_Pdf_productlist;

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


  // Future<void> getSubCollection()async{
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('Parent')
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       querySnapshot.docs.forEach((doc) {
  //
  //         // _Pdf_productlist.clear();
  //         // doc..forEach((element) {
  //         //   pdfMoled_class productModels = pdfMoled_class(
  //         //     url:element.doc['url'],
  //         //     // name:element.doc['name'],
  //         //   );
  //         //   _Pdf_productlist.add(productModels);
  //         // });
  //         FirebaseFirestore.instance.doc(doc.id)
  //             .collection("childdata")
  //             .get()
  //             .then((value){
  //           _Pdf_productlist.clear();
  //           value.docChanges.forEach((element) {
  //                pdfMoled_class productModels = pdfMoled_class(
  //                  url:element.doc['url'],
  //                  // name:element.doc['name'],
  //                );
  //                _Pdf_productlist.add(productModels);
  //              });
  //
  //         });
  //       });
  //     });
  //   // await FirebaseFirestore.instance.collection("Parent").get().then((value)  {
  //     // _Pdf_productlist.clear();
  //     // value.docChanges.forEach((element) {
  //     //   pdfMoled_class productModels = pdfMoled_class(
  //     //     url:element.doc['url'],
  //     //     // name:element.doc['name'],
  //     //   );
  //     //   _Pdf_productlist.add(productModels);
  //     // });
  //     // value.docs.forEach((element) {
  //     //   FirebaseFirestore.instance.collection("Parent")
  //     //       .doc(element.id)
  //     //       .collection("childdata")
  //     //     .get().then((snapShot){
  //     //     snapShot.docs.forEach((element) {
  //     //       print(element.data());
  //     //     });
  //        // _Pdf_productlist.clear();
  //        //    snapShot.docChanges.forEach((element) {
  //        //      pdfMoled_class productModels = pdfMoled_class(
  //        //        url:element.doc['url'],
  //        //        // name:element.doc['name'],
  //        //      );
  //        //      _Pdf_productlist.add(productModels);
  //        //    });
  //
  //   // });
  //   //
  //   //   });
  //   //   // notifyListeners();
  //   // });
  //   print("Length: " + _Pdf_productlist.length.toString());
  //   notifyListeners();
  //   } catch (error) {
  //     error.toString();
  //   }
  // }


  Future<void> getSubCategory(

      ) async {
    try {
      await FirebaseFirestore.instance.collectionGroup("childdata")
          .get()
          .then((snapShot) {
        sub_Pdf_productlist.clear();
        print("Length: " + sub_Pdf_productlist.length.toString());
        snapShot.docChanges.forEach((element) {

          pdfMoled_class productModels = pdfMoled_class(
            url:element.doc['name'],
            // name:element.doc['name'],
          );
          sub_Pdf_productlist.add(productModels);
        });

      });
      print("Length: " + sub_Pdf_productlist.length.toString());
      notifyListeners();
    } catch (error) {
      error.toString();
    }
  }




  Future<void> getCategory(

      ) async {
    try {
      await FirebaseFirestore.instance.collection("Parent")
          .get()
          .then((snapShot) {
        _Pdf_productlist.clear();
        print("Length: " + _Pdf_productlist.length.toString());
        snapShot.docChanges.forEach((element) {

          pdfMoled_class productModels = pdfMoled_class(
            name:element.doc['parent'],
              // name:element.doc['name'],
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