import 'dart:io';
import 'dart:math';

List<List<String>> board = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9'],
];

// player1 ==> X , player2 ==> O
String currentPlayer = 'O';
int player = 2;
int counter = 0;
int mod = 1;
String exit = 'y';
bool AiTurn = false;
bool playWithAi = false;


void main() {
  print("\n\n");
  while(exit == 'y' || exit == 'Y'){
    //  default values
    currentPlayer = 'O';
    player = 2;
    counter = 0;
    mod = 1;
    exit = 'y';
    AiTurn = false;
    playWithAi = false;
    // clean board 
    board = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];

    print("Welcome to Tic-Tac-Toe!");
    print("please choose : 1- for Two players mod, 2- for Vs AI mod");
    mod = int.parse(stdin.readLineSync()!);
    while(mod != 1 && mod !=2){
      print("Invalid Input ( Just 1 or 2 )");
      print("please choose : 1- for Two players mod, 2- for Vs AI mod");
      mod = int.parse(stdin.readLineSync()!);
    }
    if(mod == 1){
      displayBoard();
      while(!checkWin() && !checkDraw()){
        counter++;
        makeMove();
      }
    }else{
      playWithAi = true;
      displayBoard();
      while(!checkWin() && !checkDraw()){
        counter++;
        !AiTurn ? makeMove(): makeAIMove();
      }
    }
    
    checkWin()? print('Player $player won ! '): print('It\'s a draw!');
    print("");
    print("Restart? (y/n):");
    exit = stdin.readLineSync()!;
  }
}

void displayBoard() {
  print("");
  for (var i = 0; i < board.length; i++) {
    print(board[i].join(' | '));
    if (i < board.length - 1) {
      print('---+---+---');
    }
  }
  print("");
}



void swapTurns() {
  if(!playWithAi){
    currentPlayer = currentPlayer == 'X' ? 'O': 'X';
    player = player == 1 ? 2:1;
  }else{
    AiTurn = !AiTurn;
  }
}

void makeMove() {
  print('Player $player, please enter the number of the square where you want to place your $currentPlayer: (1-9): ');
  var move = int.parse(stdin.readLineSync()!);

  // Validate input
  if (move < 1 || move > 9) {
    print('Invalid move. Please enter a number between 1 and 9.');
    makeMove();
    return;
  }

  // Convert move to row and column indices
  var row = move <= 3 ? 0 : move <= 6 ? 1 : 2;
  var col = (move == 1 || move == 4 || move == 7) ? 0 : (move == 2 || move == 5 || move == 8) ? 1 : 2;

  // Check if the cell is empty
  if (board[row][col] == 'X' || board[row][col] == 'O') {
    print('Cell already occupied. Choose an empty cell.');
    makeMove();
    return;
  }

  // Update the board
  board[row][col] = currentPlayer;

  // Display the updated board
  displayBoard();
}


bool checkWin() {
  // Check rows, columns, and diagonals
  for (var i = 0; i < 3; i++) {
    if (board[i][0] == currentPlayer &&
        board[i][1] == currentPlayer &&
        board[i][2] == currentPlayer) {
      return true; // Row
    }
    if (board[0][i] == currentPlayer &&
        board[1][i] == currentPlayer &&
        board[2][i] == currentPlayer) {
      return true; // Column
    }
  }

  // Diagonals
  if ((board[0][0] == currentPlayer &&
          board[1][1] == currentPlayer &&
          board[2][2] == currentPlayer) ||
      (board[0][2] == currentPlayer &&
          board[1][1] == currentPlayer &&
          board[2][0] == currentPlayer)) {
    return true;
  }
  swapTurns();
  return false;
}

bool checkDraw(){
  return counter == 9;
}

// ai move use 'X'
void makeAIMove() {
  print('AI\'s turn...');
  sleep(Duration(seconds: 1)); // delay

  // Choose a random empty cell
  var emptyCells = [];
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] != 'X' && board[i][j] != 'O') {
        emptyCells.add([i, j]);
      }
    }
  }

  if (emptyCells.isNotEmpty) {
    int randomIndex = Random().nextInt(emptyCells.length);
    List chosenCell = emptyCells[randomIndex];
    board[chosenCell[0]][chosenCell[1]] = 'X';
  }
  // Display the updated board
  displayBoard();
}