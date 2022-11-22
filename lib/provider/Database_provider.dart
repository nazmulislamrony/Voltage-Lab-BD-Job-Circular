import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voltage_lab_bd_job_circular/model/pdf_model.dart';
class Pdf_Provider extends ChangeNotifier{

  CategoryClass _categoryModel=CategoryClass();
  List<CategoryClass> _CategoryList=[];
  List<CategoryClass> _subCategoryList=[];
  CategoryClass get CategoryModel => _categoryModel;
  List<CategoryClass> get CategoryList => _CategoryList;
  List<CategoryClass> get subCategoryList => _subCategoryList;



  String? _loadingMgs;
  String get loadingMgs => _loadingMgs!;



  set CategoryModel(CategoryClass value) {
    _categoryModel = value;
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
       _subCategoryList.clear();
       print("Length: " + _subCategoryList.length.toString());
       value.docChanges.forEach((element) {
         CategoryClass productModels = CategoryClass(
           name:element.doc['name'],
         );
         _subCategoryList.add(productModels);
       });
       print("Length: " + _subCategoryList.length.toString());
       notifyListeners();
    });
  }



  Future<void> getSubCollection() async {
    try {
       await FirebaseFirestore.instance.collection("Parent").get().then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance.collection("Parent").doc(element.id).collection("childdata").get().then((value) {
            value.docs.forEach((element) {
              print(element.data());
            });
          });
        });
       });




     print("Length: " + _CategoryList.length.toString());

    } catch (error) {
      error.toString();
    }
  }


  Future<void> getSubCategory(

      ) async {
    try {
      await FirebaseFirestore.instance.collectionGroup("childdata")
          .get()
          .then((snapShot) {
        _subCategoryList.clear();
        print("Length: " + _subCategoryList.length.toString());
        snapShot.docChanges.forEach((element) {
          CategoryClass productModels = CategoryClass(
            name:element.doc['name'],
            //  name:element.doc['books'],
          );
          _subCategoryList.add(productModels);

        });

      });
      print("Length: " + _subCategoryList.length.toString());
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
        _CategoryList.clear();
        print("Length: " + _CategoryList.length.toString());
        snapShot.docChanges.forEach((element) {

          CategoryClass productModels = CategoryClass(
            name:element.doc['parent'],
              // name:element.doc['name'],
          );
          _CategoryList.add(productModels);
        });

      });
      print("Length: " + _CategoryList.length.toString());
      notifyListeners();
    } catch (error) {
      error.toString();
    }
  }

}