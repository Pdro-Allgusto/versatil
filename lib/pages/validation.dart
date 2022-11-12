class Validation {
  String? campoNome(String nome) {
    if (nome.isEmpty) {
      return 'Entre com seu nome';
    }
    return null;
  }

  String? campoSobreNome(String sobrenome) {
    if (sobrenome.isEmpty) {
      return 'Entre com seu nome';
    }
    return null;
  }

  String? campoEmail(String email) {
    if (email.isEmpty) {
      return 'Entre com seu e-mail';
    }
    if (!email.contains('@')) {
      return 'O email deve ser por exemplo seu-nome@mail.com';
    }
    if (email.length < 3) {
      return 'E-mail em formato inadequado';
    }
    return null;
  }

  var truee =
      RegExp('^(?=.*[A-Z])(?=.*[!#@\$%&])(?=.*[0-9])(?=.*[a-z]).{6,15}\$');
  String? campoSenha(String senha) {
    if (senha.isEmpty) {
      return 'Entre com sua senha.';
    }
    if (senha.length < 8) {
      return 'A senha deve ter no mínimo 8 dígitos.';
    }
    if (!truee.hasMatch(senha)) {
      return 'Letra maiúscula e minúscula, numero e caracter especiais.';
    }

    return null;
  }

  String? campoEmailLogin(String email) {
    if (email.toUpperCase() != 'teste@email.com'.toUpperCase()) {
      return 'Email não cadastrado';
    }
  }

  String? campoSenhaLogin(String senha) {
    if (senha != 'Teste@123') return 'Usuario ou senha inválidos!';
  }
}
