import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/search_cubit.dart/search_cubit.dart';
import 'package:shop_app/cubit/search_cubit.dart/search_state.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    defaultFromValidation(
                        label: "search",
                        controller: searchText,
                        prefixIcon: Icons.search,
                        textInputType: TextInputType.text,
                        validation: (String value) {
                          if (value.isEmpty) {
                            return "search text must be enter";
                          }
                          return null;
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).SearchProduct(text: text);
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildItems(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,isfavorite: false),
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                  height: 1,
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchModel
                                .data
                                .data
                                .length),
                      )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
