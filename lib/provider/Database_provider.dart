import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voltage_lab_bd_job_circular/model/categorymodel.dart';
class Category_provider extends ChangeNotifier{

  Categorymodels _categoryModel=Categorymodels();
  List<Categorymodels> _CategoryList=[];
  List<Categorymodels> _subCategoryList=[];
  List<String> _id=[];
  Categorymodels get CategoryModel => _categoryModel;
  List<Categorymodels> get CategoryList => _CategoryList;
  List<Categorymodels> get subCategoryList => _subCategoryList;
  List<String> get idlist => _id;
  bool isloading=false;


  String? _loadingMgs;
  String get loadingMgs => _loadingMgs!;



  set CategoryModel(Categorymodels value) {
    // print(idlist);
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
         Categorymodels productModels = Categorymodels(
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
      List<String> dataid = [];
      List<String> data = [];
       await FirebaseFirestore.instance.collection("Parent").get().then((value) {
        value.docs.forEach((element) {
          // dataid.add(element.id);
          // data.add(element.data().toString());
           _id.add(element.id);

        });
       });
       for(int i = 0; i < dataid.length;  i++){
         CollectionReference _collection =FirebaseFirestore.instance.collection("Parent").doc(dataid[i]).collection("childdata");
         QuerySnapshot querySnapshot = await _collection.get();
       var alldata = querySnapshot.docs.map((e) => e.data().toString()).toList();
         querySnapshot.docChanges.map((element) {
           Categorymodels CategoryModels = Categorymodels(
                     name:element.doc['name'],
                   );
                   _subCategoryList.add(CategoryModels);
                   print(_subCategoryList.length.toString());
         }).toList();
       }

     // print("Length: " + _CategoryList.length.toString());
      notifyListeners();
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
        // print("Length: " + _subCategoryList.length.toString());
        snapShot.docChanges.forEach((element) {
          Categorymodels productModels = Categorymodels(
            name:element.doc['name'],
            //  name:element.doc['books'],
          );
          _subCategoryList.add(productModels);

        });

      });
      // print("Length: " + _subCategoryList.length.toString());
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
        // print("Length: " + _CategoryList.length.toString());
        snapShot.docChanges.forEach((element) {

          Categorymodels productModels = Categorymodels(
            name:element.doc['parent'],
              // name:element.doc['name'],
          );
          _CategoryList.add(productModels);
        });

      });
      // print("Length: " + _CategoryList.length.toString());
      isloading=true;
      notifyListeners();
    } catch (error) {
      error.toString();
    }
  }

}