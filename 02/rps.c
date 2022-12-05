#include "rps.h"

enum rps_t char_to_rps_t(const char input) {
  enum rps_t result = ERROR;
  switch (input) {
  case 'A':
  case 'X':
    result = ROCK;
    break;
  case 'B':
  case 'Y':
    result = PAPER;
    break;
  case 'C':
  case 'Z':
    result = SCISSORS;
    break;
  }
  return result;
}

int point_for_rps_t(enum rps_t input) {
  int result = 0;
  switch (input) {
  case ROCK:
    result = 1;
    break;
  case PAPER:
    result = 2;
    break;
  case SCISSORS:
    result = 3;
    break;
  case ERROR:
    result = 0;
    break;
  }
  return result;
}

short calculate_winner(enum rps_t opponent, enum rps_t us) {
  if (opponent == us)
    return 0;
  if (us == ROCK && opponent == SCISSORS)
    return 1;
  if (us == PAPER && opponent == ROCK)
    return 1;
  if (us == SCISSORS && opponent == PAPER)
    return 1;
  return -1;
}

int score_from_result(enum results_t input) {
  int result = 0;
  switch (input) {
  case WIN:
    result = 6;
    break;
  case DRAW:
    result = 3;
    break;
  case LOSE:
    result = 0;
    break;
  }
  return result;
}

int evaluate_game(const char op, const char us) {
  enum rps_t op_t, us_t;
  op_t = char_to_rps_t(op);
  us_t = char_to_rps_t(us);
  if (op_t == ERROR || us_t == ERROR)
    return -1;
  short winner = calculate_winner(op_t, us_t);
  enum results_t winner_result = DRAW;
  if (winner == 1)
    winner_result = WIN;
  if (winner == -1)
    winner_result = LOSE;
  int score = score_from_result(winner_result);
  int point = point_for_rps_t(us_t);
  return score + point;
}
