import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            controller.pagingController.itemList = [];
            // controller.pagingController.refresh();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                title: const Center(child: Text('hi')),
                expandedHeight: 150,
                flexibleSpace: Container(
                  color: Colors.grey,
                ),
              ),
              PagedSliverList(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<int>(
                  itemBuilder: (_, item, idx) => Container(
                    color: Colors.blueGrey,
                    height: 160,
                    width: double.infinity,
                    child: Text('item : $item'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// PagedSliverList<int, BeerSummary>(
//           pagingController: _pagingController,
//           builderDelegate: PagedChildBuilderDelegate<BeerSummary>(
//             itemBuilder: (context, item, index) => BeerListItem(
//               beer: item,
//             ),
//           ),
//         ),
