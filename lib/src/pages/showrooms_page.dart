import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/post/post_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/showroom/showroom_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/components/custom_textfield.dart';
import 'package:buy_sell_motorbike/src/components/footer.dart';
import 'package:buy_sell_motorbike/src/components/shop_card.dart';
import 'package:buy_sell_motorbike/src/components/widget_location_selector.dart';
import 'package:buy_sell_motorbike/src/model/response/showroom_response.dart';

class ShowroomsPage extends StatefulWidget {
  const ShowroomsPage({super.key});

  @override
  State<ShowroomsPage> createState() => _ShowroomsPageState();
}

class _ShowroomsPageState extends State<ShowroomsPage> {
  Future<void> _loadData() async {
    if (context.read<ShowroomCubit>().state.showrooms.isEmpty) {
      await context.read<ShowroomCubit>().getShowrooms();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cửa hàng'),
        backgroundColor: DesignConstants.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ShowroomCubit>().getShowrooms();
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              BlocBuilder<ShowroomCubit, ShowroomState>(
                builder: (_, state) {
                  final mediaQuery = MediaQuery.of(context);
                  List<Showroom> showrooms = state.showrooms;
                  return SizedBox(
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.8,
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.66,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: showrooms.length,
                      itemBuilder: (context, index) {
                        return ShowroomCard(
                          showroom: showrooms[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) => AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: DesignConstants.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const LocationSelector(),
        ],
        title: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(padding: const EdgeInsets.all(10), child: _searchInput()),
        ),
      );

  Widget? _searchInput() => TextField(
        cursorColor: Colors.black,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusColor: Colors.black,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused) ? Colors.black : Colors.grey.shade400),
            labelText: 'Tìm kiếm sản phẩm'),
      );
}
