import 'dart:io';
// import 'dart:math';

class Tabuleiro {
  List<List<String>> tabuleiro = [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' '],
  ];

  void adicionador(List<String> pos, String player) {
    int linha = int.parse(pos[0]) - 1;
    int coluna = ['a', 'b', 'c'].indexOf(pos[1]);

    // se ja tiver algo diferente de ' ' vai avisar pra trocar
    while (tabuleiro[linha][coluna] != ' ') {
      print('⚠️ Alerta: Posição já ocupada! Escolha outra.');

      List<String> novaPosicao = Gameplay().adicionaPeca();

      linha = int.parse(novaPosicao[0]) - 1;
      coluna = ['a', 'b', 'c'].indexOf(novaPosicao[1]);
    }
    tabuleiro[linha][coluna] = player; // desenha no tabuleiro
  }

  void imprimirTabuleiro() {
    // imprime o tabuleiro
    print('''
        | A | B | C
      --------------
      1 | ${tabuleiro[0][0]} | ${tabuleiro[0][1]} | ${tabuleiro[0][2]}
      --------------
      2 | ${tabuleiro[1][0]} | ${tabuleiro[1][1]} | ${tabuleiro[1][2]}
      --------------
      3 | ${tabuleiro[2][0]} | ${tabuleiro[2][1]} | ${tabuleiro[2][2]}
    ''');
  }

  void verificaGanho(List<String> pos, String player) {
    int linha = int.parse(pos[0]) - 1; // começa de 0 entao tem que subtrir
    int coluna = ['a', 'b', 'c'].indexOf(pos[1]);
    Gameplay jogo = Gameplay();

    // Verificando linha
    if (tabuleiro[linha][0] == player &&
        tabuleiro[linha][1] == player &&
        tabuleiro[linha][2] == player) {
      jogo.vencedor(player, 'l$linha');
      return;
    }

    // Verificando coluna
    if (tabuleiro[0][coluna] == player &&
        tabuleiro[1][coluna] == player &&
        tabuleiro[2][coluna] == player) {
      jogo.vencedor(player, 'c$coluna');
      return;
    }

    // Verificando diagonal principal (de cima à esquerda para baixo à direita)
    if (linha == coluna) {
      if (tabuleiro[0][0] == player &&
          tabuleiro[1][1] == player &&
          tabuleiro[2][2] == player) {
        jogo.vencedor(player, 'Diagonal principal');
        return;
      }
    }

    // Verificando diagonal secundária (de cima à direita para baixo à esquerda)
    if (linha + coluna == 2) {
      if (tabuleiro[0][2] == player &&
          tabuleiro[1][1] == player &&
          tabuleiro[2][0] == player) {
        jogo.vencedor(player, 'Diagonal secundária');
        return;
      }
    }

    // Se o jogo ainda não acabou, não fazer nada
  }
}

class Gameplay {
  late String player;
  int turno = 0;

  void vencedor(player, jeito) {
    late String forma;
    Map<String, String> linhas = {
      'l0': 'primeira linha',
      'l1': 'segunda linha',
      'l2': 'terceira linha',
      'c0': 'primeira coluna',
      'c1': 'segunda coluna',
      'c2': 'terceira coluna',
    };

    if (linhas.containsKey(jeito)) {
      forma = linhas[jeito]!;
    } else {
      forma = jeito;
    }

    stdout.write('\x1B[2J\x1B[0;0H');
    print('''                                                  
                                          $player venceu!
            A vitória foi triunfante, ó Grande Rei! Venceste pela $forma
                  Você deseja desfrutar novamente dessa EXPERIÊNCIA? (s/n):
    -----------------------------------------------------------------------------------------
    ''');

    String? jogarNovamente = stdin.readLineSync();
    if (jogarNovamente == null || jogarNovamente.isEmpty) {
      throw 'saindo!';
    }

    if (jogarNovamente.toLowerCase() == 's') {
      rodarJogo();
    } else {
      throw 'saindo!';
    }

    return;
  }

  String vez() {
    // de quem é a vez?
    if (turno <= 8) {
      player = turno % 2 == 0 ? 'X' : 'O';
      turno++;
      return player;
    } else {
      stdout.write('\x1B[2J\x1B[0;0H');
      print('''                                                  
                                           Deu velha!
                                     O jogo terminou em empate.
                    Você deseja desfrutar novamente dessa EXPERIÊNCIA? (s/n):
      -----------------------------------------------------------------------------------------
      ''');

      String? jogarNovamente = stdin.readLineSync();
      if (jogarNovamente == null || jogarNovamente.isEmpty) {
        throw 'saindo!';
      }

      if (jogarNovamente.toLowerCase() == 's') {
        rodarJogo();
      } else {
        throw 'saindo!';
      }

      return '';
    }
  }

  void hud() {
    // parte superior que diz as viadagem
    stdout.write('\x1B[2J\x1B[0;0H');
    print('''
      ➡️  Turno: $turno | Jogador atual: $player ⬅️
    ''');
  }

  List<String> adicionaPeca() {
    // posição onde voce vai colocar a peça
    while (true) {
      List<String> linhas = ['1', '2', '3'];
      List<String> colunas = ['a', 'b', 'c'];
      // perguntas
      print('Qual linha você quer jogar?');
      String? linhaLocal = stdin.readLineSync();

      print('Qual coluna você quer jogar?');
      String? colunaLocal = stdin.readLineSync();

      if (linhaLocal!.isEmpty || colunaLocal!.isEmpty) {
        print('⚠️ Alerta: Entrada inválida. Tente novamente.');
        continue;
      }

      colunaLocal = colunaLocal.toLowerCase();

      if (colunas.contains(colunaLocal) && linhas.contains(linhaLocal)) {
        List<String> posicao = [linhaLocal, colunaLocal];
        return posicao;
      } else {
        print('⚠️ Alerta: Entrada inválida. Tente novamente.');
        continue;
      }
    }
  }

  void resultadoAcao(Gameplay jogo, Tabuleiro board) {
    // avisa você de tudo que ocorreu no jogo
    String jogadorAtual = jogo.vez();
    while (true) {
      if (jogo.turno > 9) {
        break;
      }
      jogo.hud();
      board.imprimirTabuleiro();

      List<String> posicao = jogo.adicionaPeca();
      board.adicionador(posicao, jogadorAtual);
      board.verificaGanho(posicao, jogadorAtual);
      jogadorAtual = jogo.vez();
    }
  }
}

void rodarJogo() {
  // o inicializador
  Gameplay jogo = Gameplay();
  Tabuleiro board = Tabuleiro();
  while (true) {
    jogo.resultadoAcao(jogo, board);
  }
}

void main() {
  bool rodando = true;
  while (rodando) {
    stdout.write('\x1B[2J\x1B[0;0H');
    print('''
      -----------------------------------------------------------------------------------------
                                      JOGO DA VELHA EM DART
                                     Vitor Marcelo Mignoni 3F
                    Pressione qualquer tecla para começar ou (s) para sair.
      -----------------------------------------------------------------------------------------
    ''');
    String? iniciador = stdin.readLineSync();

    if (iniciador == null || iniciador.isEmpty) {
      rodarJogo();
    }

    iniciador == 's' ? rodando = false : rodarJogo();
  }
}
