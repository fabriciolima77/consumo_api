import 'package:consumo_api/data/http/http_client.dart';
import 'package:consumo_api/data/repositories/produto_repository.dart';
import 'package:consumo_api/stores/produto_store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ProdutoStore store = ProdutoStore(repository: ProdutoRepository(client: HttpClient(),
    ),
  );

  @override
  void initState(){
    super.initState();
    store.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
            'Consumo de APIs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.erro,
          store.state,
        ]),
        builder: (contex, child){
          if (store.isLoading.value) {
            return const CircularProgressIndicator();
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }  
          if (store.state.value.isEmpty) {
            return const Center(
              child: Text('Nenhum item na lista',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.separated(
                separatorBuilder: (contex, index) => const SizedBox(
                  height: 32,
                ),
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                  final item = store.state.value[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item.thumbnail!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item.title!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.barcode!,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'R\$ ${item.price}',
                                style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                ),
                              ),
                          const SizedBox(height: 4),
                            Text(
                              item.description!,
                              style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                          ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
              },
            );
          }
        },
      ),
    );
  }
}
