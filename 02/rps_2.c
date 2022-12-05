#include "rps.h"

enum results_t char_to_results_t(const char c) {
  enum results_t result = LOSE;
  switch (c) {
  case 'X':
    result = LOSE;
    break;
  case 'Y':
    result = DRAW;
    break;
  case 'Z':
    result = WIN;
    break;
  }
  return result;
}

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

enum rps_t appropriate_rps_for_outcome(enum rps_t op, enum results_t result) {
  if (result == WIN) {
    if (op == ROCK)
      return PAPER;
    if (op == SCISSORS)
      return ROCK;
    if (op == PAPER)
      return SCISSORS;
  } else if (result == LOSE) {
    if (op == ROCK)
      return SCISSORS;
    if (op == SCISSORS)
      return PAPER;
    if (op == PAPER)
      return ROCK;
  }
  return op;
}

int evaluate_game(const char op, const char us) {
  enum rps_t op_t, us_t;
  op_t = char_to_rps_t(op);
  enum results_t winner_result = char_to_results_t(us);
  if (op_t == ERROR)
    return -1;
  us_t = appropriate_rps_for_outcome(op_t, winner_result);
  int score = score_from_result(winner_result);
  int point = point_for_rps_t(us_t);
  return score + point;
}
