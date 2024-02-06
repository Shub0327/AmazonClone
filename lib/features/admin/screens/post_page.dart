import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/auth/models/product.dart';
import 'package:flutter/material.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({super.key});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  List<Product>? products;

  loadProducts() async {
    debugPrint('Getting products');

    products = await adminServices.getProduct(context: context);

    setState(
      () {},
    );
  }

  deleteCurrentProduct(String id, int index) async {
    await adminServices.deleteProduct(context: context, id: id);
    loadProducts();
    setState(() {
      products!.removeAt(index);
    });
  }

  void addProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 160,
                        child: SingleProduct(
                          img: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                          IconButton(
                            onPressed: () {
                              String? a = productData.id;
                              deleteCurrentProduct(a!, index);
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                addProduct();
              },
              tooltip: 'Add Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
