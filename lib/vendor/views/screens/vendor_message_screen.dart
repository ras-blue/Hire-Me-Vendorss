import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire_me_vendorss/vendor/views/screens/inner_screens/vendor_chat_detail.dart';

class VendorMessageScreen extends StatelessWidget {
  const VendorMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorChatsStream = FirebaseFirestore.instance
        .collection('chats')
        .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _vendorChatsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<String, String> lastProductByBuyerId = {};

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];

                Map<String, dynamic> data =
                    documentSnapshot.data()! as Map<String, dynamic>;

                String message = data['message'].toString();

                String senderId = data['senderId'].toString();

                String productId = data['productId'].toString();

                ///check if the message is from seller///
                bool isSellerMessage =
                    senderId == FirebaseAuth.instance.currentUser!.uid;

                if (!isSellerMessage) {
                  String key = senderId + '_' + productId;
                  if (!lastProductByBuyerId.containsKey(key)) {
                    lastProductByBuyerId[key] = productId;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VendorChatDetail(
                            buyerId: data['buyerId'],
                            sellerId: FirebaseAuth.instance.currentUser!.uid,
                            productId: productId,
                            data: data,
                          );
                        }));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(data['buyerPhoto']),
                        ),
                        title: Text(message),
                        subtitle: Text('sent by buyer'),
                      ),
                    );
                  }
                }
                return SizedBox.shrink();
              });
        },
      ),
    );
  }
}
