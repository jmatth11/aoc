#ifndef AOC_RPS
#define AOC_RPS

/**
 * Enums for Rock, Paper, Scissor.
 */
enum rps_t { ROCK, PAPER, SCISSORS, ERROR };

/**
 * Enums for result of a game.
 */
enum results_t { WIN, LOSE, DRAW };

/**
 * Evaluate the Rock, Paper, Scissors game.
 * @param[in] const char The opponent's answer.
 * @param[in] const char Your answer.
 * @return int The resulting score.
 */
int evaluate_game(const char, const char);

#endif
