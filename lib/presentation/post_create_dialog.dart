part of 'post_page.dart';

class PostCreateDialog extends StatefulWidget {
  const PostCreateDialog({Key? key}) : super(key: key);

  @override
  State<PostCreateDialog> createState() => _PostCreateDialogState();
}

class _PostCreateDialogState extends State<PostCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create post"),
      content: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: _titleController,
                validator: (value) => value == null || value.isEmpty
                    ? "title can't be empty"
                    : null,
              ),
            ),
            Expanded(
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: _bodyController,
                validator: (value) => value == null || value.isEmpty
                    ? "body can't be empty"
                    : null,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<PostBloc>().add(PostCreated(
                        title: _titleController.text,
                        body: _bodyController.text));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Success")));
                    _formKey.currentState!.dispose();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostPage(),
                        ));
                    super.dispose();
                  }
                },
                child: const Text("Add post"))
          ],
        ),
      ),
    );
  }
}
