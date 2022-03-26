import 'package:crud_example_shellix/models/response/http_response.dart';
import 'package:crud_example_shellix/providers/users_provider.dart';
import 'package:crud_example_shellix/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:crud_example_shellix/models/element.dart' as e;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addUser() {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context, listen: false);
    var formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: usersProvider.typedName,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Lütfen bu alanı doldurunuz';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    usersProvider.setName(val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Ad giriniz',
                    border: OutlineInputBorder(),
                    focusedBorder: (OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: usersProvider.typedImage,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Lütfen bu alanı doldurunuz';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    usersProvider.setImage(val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Resim giriniz',
                    border: OutlineInputBorder(),
                    focusedBorder: (OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (val) {
                    usersProvider.setBirthday(val);
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Lütfen bu alanı doldurunuz';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Doğum tarihi seçiniz',
                    border: OutlineInputBorder(),
                    focusedBorder: (OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tüm alanları doldurunuz')));
                      }

                      HttpResponse httpResponse = await usersProvider.addNewElement();
                      if (httpResponse.isSuccesfull) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Başarılı bir şekilde oluşturuldu')));
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(httpResponse.data ?? 'Bir hata oluştu.')));
                      }
                    },
                    child: const Text('Oluştur')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editUser(e.Element element) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context, listen: false);
    var formKey = GlobalKey<FormState>();

    usersProvider.typedImage = element.image;
    usersProvider.typedName = element.name;
    usersProvider.pickedBirthday = element.birthday;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: usersProvider.typedName,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Lütfen bu alanı doldurunuz';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    usersProvider.setName(val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Ad giriniz',
                    border: OutlineInputBorder(),
                    focusedBorder: (OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: usersProvider.typedImage,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Lütfen bu alanı doldurunuz';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    usersProvider.setImage(val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Resim giriniz',
                    border: OutlineInputBorder(),
                    focusedBorder: (OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (val) {
                    usersProvider.setBirthday(val);
                  },
                  initialValue:
                      '${usersProvider.pickedBirthday!.year}-${usersProvider.pickedBirthday!.month.toString().padLeft(2, '0')}-${usersProvider.pickedBirthday!.day.toString().padLeft(2, '0')}',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Lütfen bu alanı doldurunuz';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Doğum tarihi seçiniz',
                    border: OutlineInputBorder(),
                    focusedBorder: (OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tüm alanları doldurunuz')));
                        return;
                      }

                      HttpResponse httpResponse = await usersProvider.updateElemenet(element);
                      if (httpResponse.isSuccesfull) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Başarılı bir şekilde güncellendi')));
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(httpResponse.data ?? 'Bir hata oluştu.')));
                      }
                    },
                    child: const Text('Oluştur')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    List<e.Element> allElements = usersProvider.allElements;
    bool allElementsGet = usersProvider.allElementsGet;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud API Example'),
      ),
      body: Builder(builder: (context) {
        if (!allElementsGet) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: allElements.length,
          itemBuilder: (context, index) {
            e.Element element = allElements[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Image.network(element.image),
                  backgroundColor: Colors.white,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await usersProvider.deleteElement(element);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                        onPressed: () {
                          editUser(element);
                        },
                        icon: const Icon(Icons.edit)),
                  ],
                ),
                title: Text(element.name),
                subtitle: Text(element.getYersOld().toString()),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: addUser,
      ),
    );
  }
}
