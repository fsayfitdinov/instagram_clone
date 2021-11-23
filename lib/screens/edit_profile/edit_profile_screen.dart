import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/models/user_model.dart';

import 'package:instagram/screens/profile/bloc/profile_bloc.dart';
import 'package:instagram/widgets/widgets.dart';
import '../../repositories/repositories.dart';
import './cubit/edit_profile_cubit.dart';

class EditProfileArgs {
  final BuildContext context;

  const EditProfileArgs({required this.context});
}

class EditProfileScreen extends StatelessWidget {
  static const routeName = 'editProfile';

  final UserModel user;
  EditProfileScreen({Key? key, required this.user}) : super(key: key);

  static Route route({required EditProfileArgs args}) {
    return CupertinoPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (context) => EditProfileCubit(
          profileBloc: args.context.read<ProfileBloc>(),
          storageRepository: context.read<StorageRepository>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: EditProfileScreen(
          user: args.context.read<ProfileBloc>().state.user,
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state.status == EditProfileStatus.success) {
              Navigator.pop(context);
            } else if (state.status == EditProfileStatus.error) {
              showDialog(context: context, builder: (context) => ErrorDialog(content: state.failure.message));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => _selectProfileImage(context),
                    child: UserProfileImage(
                      radius: 80,
                      profileImageUrl: user.profileImageUrl,
                      profileImage: state.profileImage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            initialValue: user.username,
                            decoration: InputDecoration(hintText: 'Username'),
                            onChanged: (value) => context.read<EditProfileCubit>().usernameChanged(value),
                            validator: (value) => value!.isEmpty ? 'Username cannot be empty' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: user.bio,
                            decoration: InputDecoration(hintText: 'bio'),
                            onChanged: (value) => context.read<EditProfileCubit>().bioChanged(value),
                            validator: (value) => value!.isEmpty ? 'Bio cannot be empty' : null,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 1.0,
                            ),
                            onPressed: () => _submitForm(context, state.status == EditProfileStatus.submitting),
                            child: Text('Update'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _selectProfileImage(BuildContext context) {
    //
  }

  _submitForm(BuildContext context, bool isSubmitting) {
    final valid = _formKey.currentState!.validate();
    if (valid && !isSubmitting) {
      context.read<EditProfileCubit>().submit();
    }
  }
}
