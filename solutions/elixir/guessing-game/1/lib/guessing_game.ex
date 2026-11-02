defmodule GuessingGame do
  def compare(_secret_number, guess \\:no_guess) when guess == :no_guess, do: "Make a guess"
  def compare(secret_number, guess) when guess > secret_number + 1, do: "Too high"
  def compare(secret_number, guess) when guess < secret_number - 1, do: "Too low"
  def compare(secret_number, guess) when guess > secret_number or guess < secret_number, do: "So close"
  def compare(_secret_number, _guess) do
    "Correct"
  end
end
