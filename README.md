# USAR EXIT 0

# Jogo da Velha usando Dart
Usando os princípios de programação orientada a objetos, o projeto constitui-se num jogo funcional de jogo da velha, capaz de identificar vitória, empate e iniciar um novo jogo, após a vitória. **futuramente ele irá contar quantas vitórias cada jogaodr teve, qual o total de turnos e a média de vitórias de cada um, além de ter a opção de jogar com um bot.** <br>
Inicialmente criada para uma lista de atividade na disciplina de Desenvolvimento para Dispositivos móveis, o jogo da velha foi uma forma de praticar POO e boas práticas, além de uma ótima maneira de fixar o aprendizado da linguagem. <br>
Como este é meu primeiro projeto com certa complexidade em Dart, tive o desafio de tentar transformar o código no de mais fácil leitura possível, comentando-o conforme aplicava e desenvolvendo-o de maneira simples mas eficaz.

## 🎮 Como Jogar
Baixe o código em sua máquina, e em um terminal digite:
```bash
dart jogoDaVelha.dart
```
Isso fará com que o código rode. A partir desse ponto, o jogo terá menus para que você se localize e possa jogar o jogo como preferir.<br><br>
---
<br><br>
## 👨‍💻 Desenvolvimento
Essa seção é dedicada à explicação do código. <br>

### > Biblioteca 'dart:io'
Esta biblioteca é responsável por inputs e outputs. Ou seja, ela garante que você, usuário, possa anexar uma string nullável no terminal e que o código possa ler ele como resposta da posição, por exemplo. Além disso, essa biblioteca trás a possibilidade de usar uma 'limpeza' no terminal para que você tenha mais legibilidade (com o código 'stdout.write('\x1B[2J\x1B[0;0H')'.

### > Classes 'Tabuleiro' e 'Gameplay'
Essas são as classes pai de todo o esqueleto do código, responsáveis por relações do usuário - jogo. <br>
A classe **Tabuleiro** é a responsável por todas as interações que o mesmo suporta, além de imprimir o tabuleiro para a visualização do usuário. Tudo que acontece com o tabuleiro é verificado aqui. <br>
A classe **Gameplay** é voltada para a visualização e comportamento que o usuário realiza -- ou pode realizar. Nesta classe, temos uma função crucial para que o jogo seja possível com representação gráfica, sendo ela a 'resultadoAcao', que serve como um realizador de todas as tarefas, responsável por chamá-las e mostrá-las. Dentro desta mesma classe, temos as questões de input do player.
