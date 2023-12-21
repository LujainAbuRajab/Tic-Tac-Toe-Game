import 'dart:io';
import 'dart:core';

bool winner = false;
bool isXturn = true;

List<String> cordinates = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> combinations = [
  '012',
  '048',
  '036',
  '147',
  '246',
  '258',
  '345',
  '678'
];

void main() {
  generateBoard();
  getnextCharacter();
}

//initial value of moves
int movementCount = 0;

//check if a combination is true or false for a player (X or 0)
bool checkCombination(String combination, String checkFor) {
  //split the numbers in a list of integers
  List<int> numbers = combination.split('').map((item) {
    return int.parse(item);
  }).toList();

  bool match = false;
  for (final item in numbers) {
    if (cordinates[item] == checkFor) {
      match = true;
    } else {
      match = false;
      break;
    }
  }
  return match;
}

void checkWinner(player) {
  for (final item in combinations) {
    bool combinationValidity = checkCombination(item, player);
    if (combinationValidity == true) {
      print('$player WON!');
      winner = true;
      break;
    }
  }
}

//get input, check winners
void getnextCharacter() {
  //get input from player
  print('Choose Number for ${isXturn == true ? "X" : "O"}');

  //read the input as a string, and wait for the user to input sth.
  //Then convert the input from string to integer using int.parse()
  int number = int.parse(stdin.readLineSync()!);

  //change the value of selected number(isXturn) true->X, else->O
  //[number-1] because indexing start from 0
  cordinates[number - 1] = isXturn ? 'X' : 'O';

  //change player turn
  isXturn = !isXturn;

  //increment move count
  movementCount++;
  if (movementCount == 9) {
    winner = true;
    print('DOONE!');
  } else {
    //clear the console
    clearScreen();

    //redraw the board with the new information
    generateBoard();
  }

  //Check Validity for players, declare winner
  //check validity for player X
  checkWinner('X');

  //check validity for player O
  checkWinner('O');

  //until we have a winner, we call current function again
  if (winner == false) getnextCharacter();
}

//This function is typically used in command-line applications
//to provide a cleaner interface for the user.
void clearScreen() {
  if (Platform.isWindows) {
    print(Process.runSync("cls", [], runInShell: true).stdout);
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

//show current state of board
void generateBoard() {
  print('   |   |   ');
  print(' ${cordinates[0]} | ${cordinates[1]} | ${cordinates[2]} ');
  print('___|___|___');
  print('   |   |   ');
  print(' ${cordinates[3]} | ${cordinates[4]} | ${cordinates[5]} ');
  print('___|___|___');
  print('   |   |   ');
  print(' ${cordinates[6]} | ${cordinates[7]} | ${cordinates[8]} ');
  print('   |   |   ');
}
