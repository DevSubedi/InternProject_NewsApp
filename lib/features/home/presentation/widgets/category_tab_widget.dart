import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/news_card_widget.dart';

class CategoryTabWidget extends StatelessWidget {
  const CategoryTabWidget({super.key});
  final List<String> categories = const [
    'All',
    'Technology',
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
  ];

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: categories.map((c) {
        return BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state.categoryStatus == DataStatus.loading &&
                state.selectedCategory.toLowerCase() == c.toLowerCase()) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.categoryStatus == DataStatus.error &&
                state.selectedCategory.toLowerCase() == c.toLowerCase()) {
              return Center(child: Text(state.message ?? 'Error'));
            }

            if (state.categoryNews.isEmpty &&
                state.selectedCategory.toLowerCase() == c.toLowerCase()) {
              return const Center(child: Text('No news found.'));
            }

            if (state.categoryStatus == DataStatus.loaded) {
              return ListView.builder(
                itemCount: state.categoryNews.length,
                itemBuilder: (context, index) {
                  return NewsCardWidget(singleNews: state.categoryNews[index]);
                },
              );
            }
            return Container();
          },
        );
      }).toList(),
    );
  }
}

//before the NestedScrollView

// class CategoryTabWidget extends StatelessWidget {
//   const CategoryTabWidget({super.key});
//   final List<String> categories = const [
//     'All',
//     'Technology',
//     'Business',
//     'Entertainment',
//     'General',
//     'Health',
//     'Science',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: categories.length,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.h),
//             child: Row(
//               children: [
//                 TextWidget(word: 'Latest', size: 18.h, weight: FontWeight.w500),
//               ],
//             ),
//           ),

//           Material(
//             color: Colors.transparent,
//             child: TabBar(
//               isScrollable: true,

//               enableFeedback: true,
//               dividerHeight: 0,
//               tabAlignment: TabAlignment.start,
//               labelColor: Colors.blue,
//               unselectedLabelColor: Colors.black,
//               // indicator: BoxDecoration(), to remove the bottom indicator
//               tabs: categories.map((c) => Tab(text: c)).toList(),
//               onTap: (index) {
//                 final CategoryName = categories[index];
//                 context.read<NewsBloc>().add(
//                   SelectCategoryEvent(selectedCategoryEvent: CategoryName),
//                 );
//                 // context.read<NewsBloc>().add(FetchCategoryNewsEvent());
//               },
//             ),
//           ),
//           10.verticalSpace,
//           Expanded(
//             child: TabBarView(
//               children: categories.map((c) {
//                 return BlocBuilder<NewsBloc, NewsState>(
//                   builder: (context, state) {
//                     if (state.categoryStatus == DataStatus.loading &&
//                         state.selectedCategory?.toLowerCase() ==
//                             c.toLowerCase()) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (state.categoryStatus == DataStatus.error &&
//                         state.selectedCategory?.toLowerCase() ==
//                             c.toLowerCase()) {
//                       return Center(child: Text(state.message ?? 'Error'));
//                     }

//                     if (state.categoryNews.isEmpty &&
//                         state.selectedCategory?.toLowerCase() ==
//                             c.toLowerCase()) {
//                       return const Center(child: Text('No news found.'));
//                     }

//                     // The loaded news list for this category
//                     if (state.categoryStatus == DataStatus.loaded) {
//                       return ListView.builder(
//                         itemCount: state.categoryNews.length,
//                         itemBuilder: (context, index) {
//                           return NewsCardWidget(
//                             singleNews: state.categoryNews[index],
//                           );
//                         },
//                       );
//                     }
//                     return Container();
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
