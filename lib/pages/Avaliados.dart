class Avaliado {
  int? rank;
  String? nome;
  String? preco;
  double? avaliacao;

  Avaliado(this.rank, this.nome, this.preco, this.avaliacao);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'rank': rank,
      'nome': nome,
      'preco': preco,
      'avaliacao': avaliacao,
    };
    return map;
  }

  Avaliado.fromMap(Map<String, dynamic> map) {
    rank = map['rank'];
    nome = map['nome'];
    preco = map['preco'];
    avaliacao = map['avaliacao'];
  }
  @override
  String toString() {
    return "Local: => (Rank: $rank, nome: $nome, preco: $preco, avalição: $avaliacao)";
  }
}
