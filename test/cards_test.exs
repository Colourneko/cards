defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates a deck with 52 cards" do
    deck = Cards.create_deck()
    assert length(deck) == 52
  end

  test "create_deck contains Ace of Spades" do
    deck = Cards.create_deck()
    assert "Ace of Spades" in deck
  end

  test "shuffle changes the order of the deck" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    refute deck == shuffled_deck
  end

  test "contains? returns true for a card in the deck" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Ace of Spades")
  end

  test "contains? returns false for a card not in the deck" do
    deck = Cards.create_deck()
    refute Cards.contains?(deck, "Joker")
  end

  test "deal splits the deck into hand and remaining deck" do
    deck = Cards.create_deck()
    {hand, remaining_deck} = Cards.deal(deck, 5)
    assert length(hand) == 5
    assert length(remaining_deck) == 47
  end

  test "save and load deck" do
    deck = Cards.create_deck()
    Cards.save(deck, "my_deck")
    assert File.exists?("my_deck")
    loaded_deck = Cards.load("my_deck")
    assert deck == loaded_deck
    File.rm!("my_deck")
  end

  test "load returns error message for non-existent file" do
    assert Cards.load("non_existent_deck") == "Failed to read file: non_existent_deck"
  end

  test "create_hand returns the correct number of cards" do
    hand = Cards.create_hand(5)
    assert length(hand) == 5
  end
end
