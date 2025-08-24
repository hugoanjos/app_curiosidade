class Pessoa {
  final int id;
  final String nome;
  final int idade;
  final String email;
  final String endereco;
  final String outrasInformacoes;
  final String interesses;
  final String sentimentos;
  final String valores;
  final DateTime dataCadastro;
  final bool ativo;
  final bool deletado;

  Pessoa({
    required this.id,
    required this.nome,
    required this.idade,
    required this.email,
    required this.endereco,
    required this.outrasInformacoes,
    required this.interesses,
    required this.sentimentos,
    required this.valores,
    required this.dataCadastro,
    required this.ativo,
    required this.deletado,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      id: json['Id'],
      nome: json['Nome'],
      idade: json['Idade'],
      email: json['Email'],
      endereco: json['Endereco'],
      outrasInformacoes: json['OutrasInformacoes'],
      interesses: json['Interesses'],
      sentimentos: json['Sentimentos'],
      valores: json['Valores'],
      dataCadastro: DateTime.parse(json['DataCadastro']),
      ativo: json['Ativo'],
      deletado: json['Deletado'],
    );
  }
}
