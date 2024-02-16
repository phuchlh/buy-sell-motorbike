import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cubit/post/post_cubit.dart';
import '../blocs/cubit/showroom/showroom_cubit.dart';
import '../common/constants.dart';
import '../components/custom_textfield.dart';
import '../components/footer.dart';
import '../components/shop_card.dart';
import '../components/widget_location_selector.dart';
import '../model/response/showroom_response.dart';

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

  Future<void> _refresh() async {
    await context.read<ShowroomCubit>().getShowrooms();
  }

  List<String> location = ['Toàn quốc', 'Hồ Chí Minh', 'Hà Nội'];
  String pickedLocation = "";

  @override
  void initState() {
    super.initState();
    _loadData();
    pickedLocation = location.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConstants.primaryColor,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                onChangedString:
                    context.read<ShowroomCubit>().onChangeSearchString,
                title: 'Tìm kiếm',
                hintText: 'Bạn chỉ việc nhập tên showroom',
                keyboardType: TextInputType.text,
                endIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: 18, color: Colors.grey.shade600),
                Text(
                  'Khu vực tìm kiếm: ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Danh sách khu vực',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: location
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: pickedLocation,
                    onChanged: (String? value) {
                      setState(() {
                        pickedLocation = value.toString();
                      });
                      context
                          .read<ShowroomCubit>()
                          .onChangeLocation(value.toString());
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 160,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<ShowroomCubit, ShowroomState>(
              builder: (_, state) {
                final mediaQuery = MediaQuery.of(context);
                List<Showroom> showrooms = state.showrooms;
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: SizedBox(
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.7,
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
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
                  ),
                );
              },
            ),
          ],
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
          child: Container(
              padding: const EdgeInsets.all(10), child: _searchInput()),
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
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusColor: Colors.black,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? Colors.black
                    : Colors.grey.shade400),
            labelText: 'Tìm kiếm sản phẩm'),
      );
}
