import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout_cubit/lay_out_cubit.dart';

class SearchBarr extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return    TextFormField(
      onChanged: (input){
        cubit.filterdProducts(input: input);
      },
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.3),
        filled: true,
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search',
        suffixIcon: const Icon(Icons.clear),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
