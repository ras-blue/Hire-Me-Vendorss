import 'package:flutter/material.dart';
import 'package:hire_me_vendorss/vendor/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool? _chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Charge Shipping'),
          value: _chargeShipping,
          onChanged: (value) {
            setState(() {
              _chargeShipping = value;
            });

            _productProvider.getFormData(chargeShipping: _chargeShipping);
          },
        ),
        if (_chargeShipping == true)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter fee';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(
                    shippingCharge: double.parse(value));
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Shipping Charge Fee',
                hintText: 'Enter Shipping Charge',
              ),
            ),
          )
      ],
    );
  }
}
