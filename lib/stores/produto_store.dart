import 'package:consumo_api/data/http/exceptions.dart';
import 'package:consumo_api/data/models/produto_model.dart';
import 'package:consumo_api/data/repositories/produto_repository.dart';
import 'package:flutter/material.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  //Variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //Variavel reativa para o state
  final ValueNotifier<List<ProdutoModel>> state =
  ValueNotifier<List<ProdutoModel>>([]);

  //Variavel reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}