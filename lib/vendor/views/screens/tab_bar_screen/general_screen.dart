import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hire_me_vendorss/vendor/provider/product_provider.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('Categories')
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter product name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Product Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter product price';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(
                      productPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Enter Product Price',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter product quantity';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(
                      productQuantity: int.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Enter Product Quantity',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                  hint: Text(
                    'Select Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  items: _categoryList.map<DropdownMenuItem<dynamic>>((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {
                    _productProvider.getFormData(category: value);
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter description';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                maxLines: 10,
                minLines: 3,
                maxLength: 800,
                decoration: InputDecoration(
                  hintText: 'Enter product description',
                  labelText: 'Product Description',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
