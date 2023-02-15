import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/index/fetch_me_controller.dart';
import 'package:pyc/screens/index/components/index_drawer_list_title.dart';

class IndexDrawer extends StatelessWidget {
  final Size size;
  final String name;

  const IndexDrawer({
    Key? key,
    required this.size,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.6,
      child: Drawer(
        child: Container(
          color: kPrimaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              /// DrawerHeader (Drawer가 열렸을 때 좌측 상단 X버튼 & Welcome Text)
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '반가워요 $name님!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        kQuarterHeightSizedBox,
                        const Text(
                          '무엇을 도와드릴까요?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        kHalfHeightSizeBox,
                      ],
                    ),
                  ],
                ),
              ),
              kHeightSizeBox,
              IndexDrawerListTitle(
                icon: 'assets/icons/drawer_manager_cell.png',
                title: '셀 관리',
                onTap: () {},
              ),
              kQuarterHeightSizedBox,
              IndexDrawerListTitle(
                icon: 'assets/icons/drawer_notice.png',
                title: '공지사항',
                onTap: () {},
              ),
              kQuarterHeightSizedBox,
              IndexDrawerListTitle(
                icon: 'assets/icons/drawer_logout.png',
                title: '로그아웃',
                onTap: () async => Get.find<FetchMeController>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
