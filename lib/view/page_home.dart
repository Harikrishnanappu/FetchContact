import 'dart:math';
import 'dart:typed_data';
import 'package:custom_contact/constants/colors.dart';
import 'package:custom_contact/widget/circleavatar.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Contact> contacts = [];
  String? inital;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

//____________________________ Ask Permission

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

//_______________   Get Contact From Device
  void fetchContacts() async {
    contacts = await ContactsService.getContacts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (cntx, index) {
                    Uint8List? image = contacts[index].avatar;
                    String? name = contacts[index].displayName;
                    String? phone = contacts[index].phones!.isNotEmpty
                        ? contacts[index].phones!.first.value
                        : "";
                    name!.isNotEmpty ? inital = name[0] : 'Unknown';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () {
                          name;
                          image;

                          debugPrint(name);
                        },
                        title: Text(
                          name.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, color: kwhitecolor),
                        ),
                        subtitle: Text(
                          phone!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, color: kgreycolor),
                        ),
                        leading: image == null || image.isEmpty
                            ? AvatarCircle(inital: inital)
                            : CircleAvatar(
                                backgroundImage: MemoryImage(image),
                                radius: 30,
                              ),
                      ),
                    );
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
