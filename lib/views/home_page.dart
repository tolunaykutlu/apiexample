import 'package:apiexample/models/rick_morty_model.dart';
import 'package:apiexample/riverpods/get_ram_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(dataProvider);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("Rick And Morty"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height * 0.9,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return data.when(
              data: (data) {
                return dataTiles(data, index, context);
              },
              error: (error, stackTrace) {
                return Text("$error");
              },
              loading: () => const CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(pageProvider.notifier).state++;
        },
        child: const Icon(Icons.forward_sharp),
      ),
    );
  }

  Padding dataTiles(RaMData data, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      child: SizedBox(
          height: 100,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      Text(data.results![index].species.toString()),
                      Text(data.results![index].status.toString())
                    ],
                    title: Text(data.results![index].name.toString()),
                    content:
                        Image.network(data.results![index].image.toString()),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: ListTile(
                  leading: Text(data.results![index].id.toString()),
                  trailing:
                      Image.network(data.results![index].image.toString()),
                  subtitle:
                      Text(data.results![index].location!.name.toString()),
                  title: Text(data.results![index].name.toString()),
                ),
              ),
            ),
          )),
    );
  }
}
