import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../provider/orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // var _isLoading = false;

  late Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }

  @override
  void initState() {

    _ordersFuture=_obtainOrdersFuture();
    // Future.delayed(Duration.zero).then(
    // (_) async {
    // setState(
    // () {
    // _isLoading = true;
    //   },
    // );
    // await
    // Provider.of<Orders>(context, listen: false).fetchAndSetOrder().then(
    //   (_) {
    //     setState(
    //       () {
    // _isLoading = false;
    // },
    // );
    // });
    // },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.error != null) {
            //error handling
            return Center(
              child: Text('An error occured'),
            );
          } else {
            return Consumer<Orders>(
              builder: (BuildContext context, orderData, Widget? child) {
                return ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderItemWidget(orderData.orders[index]);
                  },
                );
              },
            );
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
