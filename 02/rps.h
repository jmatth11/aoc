#ifndef AOC_RPS
#define AOC_RPS

enum rps_t { ROCK, PAPER, SCISSORS, ERROR };

enum results_t { WIN, LOSE, DRAW };

int evaluate_game(const char, const char);

#endif
