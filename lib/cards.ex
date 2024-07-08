defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of playing cards.
  """

  @doc """
  Creates and returns a list of strings representing a deck of playing cards.
  Each card is represented in the format: "<Value> of <Suit>".

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Enum.take(deck, 5)
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades"]
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values, do: "#{value} of #{suit}"
  end

  @doc """
  Shuffles the given deck of cards.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> shuffled_deck = Cards.shuffle(deck)
      iex> Enum.take(shuffled_deck, 5)
      ["Six of Hearts", "King of Diamonds", "Two of Clubs", "Five of Clubs", "Ten of Diamonds"]
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Checks if a specific card is present in the deck.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      iex> Cards.contains?(deck, "Joker")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck. The `hand_size`
  argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, remaining_deck} = Cards.deal(deck, 5)
      iex> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades"]
      iex> remaining_deck
      ["Six of Spades", "Seven of Spades", ...]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves the given deck to a file in binary format.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.save(deck, "my_deck")
      :ok
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads a deck from a file previously saved with `Cards.save/2`.

  ## Examples

      iex> loaded_deck = Cards.load("my_deck")
      iex> Enum.take(loaded_deck, 5)
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades"]

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} ->
        case :erlang.binary_to_term(binary) do
          {:ok, deck} -> deck
          _error -> "Failed to decode deck from binary"
        end
      {:error, _reason} ->
        "Failed to read file: #{filename}"
    end
  end

  @doc """
  Creates a hand of cards by creating a deck, shuffling it, and dealing the specified `hand_size`.

  ## Examples

      iex> hand = Cards.create_hand(5)
      iex> Enum.each(hand, &IO.puts(&1))
      Ace of Spades
      Two of Spades
      Three of Spades
      Four of Spades
      Five of Spades

  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
    |> elem(0)  # Extract the hand from the result of deal/2
  end
end
