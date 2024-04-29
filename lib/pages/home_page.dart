
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo20_provayder/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import '../models/random_user_list_res.dart';
import '../service/http_service.dart';
import '../views/item_random_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
HomeViewModel viewModel =HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel.initScrollListener();


    viewModel.loadRandomUserList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Random Users - Provider"),
      ),
      body: ChangeNotifierProvider(
        create: (context)=>viewModel,
        child:  Consumer<HomeViewModel>(
          builder: (ctx,model,index)=>
              Stack(
                children: [
                  ListView.builder(
                    controller: viewModel.scrollController,
                    itemCount: viewModel.userList.length,
                    itemBuilder: (ctx, index) {
                      return itemOfRandomUser(viewModel.userList[index], index);
                    },
                  ),

                  viewModel.isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : const SizedBox.shrink(),
                ],
              ),
        ),
      )
    );
  }


}