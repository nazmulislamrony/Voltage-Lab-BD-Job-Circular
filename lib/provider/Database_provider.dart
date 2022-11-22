import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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


  Future <void> getSubdata()async{
    try {
      FirebaseFirestore.instance.collection("Category").orderBy("SubCategoryParentId").where("Pass your Subcategory Id here");
    } catch (error) {
      error.toString();
    }
  }

  Future<void> getdata()async{
    CollectionReference ref= FirebaseFirestore.instance.collection("Parent");
     ref.doc("9K9g8kbpA60kzIHJT4HQ").collection("childdata").get().then((value){
       sub_Pdf_productlist.clear();
       print("Length: " + sub_Pdf_productlist.length.toString());
       value.docChanges.forEach((element) {
         pdfMoled_class productModels = pdfMoled_class(
           name:element.doc['name'],
         );
         sub_Pdf_productlist.add(productModels);
       });
       print("Length: " + sub_Pdf_productlist.length.toString());
       notifyListeners();
    });
  }



  // Future<void> getSubCollection() async {
  //   try {
  //    await  FirebaseFirestore.instance.collection("Parent")
  //     .get().
  //     then((snapShot) {
  //      _Pdf_productlist.clear();
  //      print("Length: " + _Pdf_productlist.length.toString());
  //       snapShot.docChanges.forEach((element) {
  //           pdfMoled_class productModels = pdfMoled_class(
  //             name:element.doc['parent'],
  //           );
  //           _Pdf_productlist.add(productModels);
  //       });
  //           print("Length: parent" + _Pdf_productlist.length.toString());
  //
  //
  //           FirebaseFirestore.instance.collectionGroup("childdata").where('id', isEqualTo: '1')
  //           .get()
  //           .then((value) {
  //                 sub_Pdf_productlist.clear();
  //                 print("Length: " + sub_Pdf_productlist.length.toString());
  //             value.docChanges.forEach((element) {
  //                     pdfMoled_class productModels = pdfMoled_class(
  //                       // url:element.doc['name'],
  //                       name:element.doc['name'],
  //                     );
  //                     sub_Pdf_productlist.add(productModels);
  //                     print("Length: child " + sub_Pdf_productlist.length.toString());
  //                     notifyListeners();
  //             });
  //           });
  //     });
  //
  //    print("Length: " + _Pdf_productlist.length.toString());
  //
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
            //  name:element.doc['books'],
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