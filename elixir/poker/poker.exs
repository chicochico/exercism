defmodule Poker do
  @type poker_hand :: [String.t()]

  @hand_rank %{
      straight_flush: 8,
      four_of_a_kind: 7,
      full_house: 6,
      flush: 5,
      straight: 4,
      three_of_a_kind: 3,
      two_pairs: 2,
      one_pair: 1,
      high_card: 0
  }

  @card_rank %{
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "J" => 11,
      "Q" => 12,
      "K" => 13,
      "A" => 14,
  }

  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand([poker_hand]) :: [poker_hand]
  def best_hand([hand]), do: [hand]
  def best_hand(hands) do
    hands
    |> Enum.map(&classify(&1))
    |> get_best_hand_by_rank
    |> case do
      [{_, hand}] -> [hand]
      hands -> break_ties(hands)
    end
  end


  @doc """
  Get a list of classified hands and returns the strongest hands
  """
  @spec get_best_hand_by_rank([{atom, poker_hand}]) :: [{atom, poker_hand}]
  def get_best_hand_by_rank(hands) do
    [best_rank | _] =
      hands
      |> Enum.map(fn {rank, _hand} -> rank end)
      |> Enum.sort(fn rank1, rank2 ->
        @hand_rank[rank1] > @hand_rank[rank2]
      end)

    hands
    |> Enum.filter(fn {rank, _} -> rank == best_rank end)
  end

  @doc """
  Sum the rank of the cards and returns the hand
  with the highest score
  """
  @spec get_best_hand_by_score([poker_hand]) :: poker_hand
  def get_best_hand_by_score(hands) do
    [best_hand | _] =
      hands
      |> Enum.sort(fn hand1, hand2 ->
        calculate_hand_score(hand1) > calculate_hand_score(hand2)
      end)

    [best_hand]
  end

  @doc """
  Sum the rank of the cards of a hand
  """
  @spec calculate_hand_score(poker_hand) :: integer
  def calculate_hand_score(hand) do
    hand
    |> Enum.map(&split_rank_suit(&1))
    |> Enum.map(fn {rank, _suit} -> rank end)
    |> Enum.map(&(@card_rank[&1]))
    |> Enum.sum
  end

  @spec break_ties([poker_hand]) :: [poker_hand]
  def break_ties([{hand_rank, _} | _] = hands) do
    hands
    |> Enum.map(fn {_hand_rank, hand_cards} -> hand_cards end)
    |> break_ties(hand_rank)
  end
  def break_ties(hands, rank) do
    case rank do
      :high_card ->
        break_high_card_tie(hands)
      :two_pairs ->
        break_two_pairs_tie(hands)
      :straight ->
        break_straight_tie(hands)
      _ -> get_best_hand_by_score(hands)
    end
  end

  @spec break_high_card_tie([poker_hand]) :: [poker_hand]
  def break_high_card_tie(hands) do
    tie_breaker =
      hands
      |> Enum.map(&sort_cards(&1))
      |> Enum.map(&extract_ranks(&1))
      |> Enum.zip
      |> Enum.map(&Tuple.to_list(&1))
      |> Enum.map(&Enum.dedup(&1))
      |> Enum.reverse
      |> Enum.drop_while(fn hand -> length(hand) == 1 end)
      |> List.first
      |> Enum.max

    hands
    |> Enum.filter(fn hand ->
      hand
      |> extract_ranks
      |> Enum.any?(fn rank -> rank == tie_breaker end)
    end)
  end

  @spec break_two_pairs_tie([poker_hand]) :: [poker_hand]
  def break_two_pairs_tie(hands) do
    [{_, hand_index} | _] =
      hands
      |> Enum.map(&sort_cards(&1))
      |> Enum.map(&extract_ranks(&1))
      |> Enum.map(fn hand ->
        case hand do
          [k, p1, p1, p2, p2] -> {k, p1, p2}
          [p1, p1, k, p2, p2] -> {k, p1, p2}
          [p1, p1, p2, p2, k] -> {k, p1, p2}
        end
      end)
      |> Enum.with_index
      |> Enum.sort(fn {{k1, pa1, pb1}, _}, {{k2, pa2, pb2}, _} ->
        cond do
          pb1 != pb2 -> pb1 > pb2
          pa1 != pa2 -> pa1 > pa2
          k1 != k2 -> k1 > k2
          true -> true
        end
      end)

    [Enum.at(hands, hand_index)]
  end

  @spec break_straight_tie([poker_hand]) :: [poker_hand]
  def break_straight_tie(hands) do
    {_, hand_index} =
      hands
      |> Enum.map(&sort_cards(&1))
      |> Enum.map(&extract_ranks(&1))
      |> Enum.map(fn hand ->
        hand
        |> Enum.map(fn rank ->
          case rank do
            "A" -> 0
            _ -> @card_rank[rank]
          end
        end)
      end)
      |> Enum.map(&Enum.sum(&1))
      |> Enum.with_index
      |> Enum.max

    [Enum.at(hands, hand_index)]
  end

  @doc """
  Strip the suits from the hand
  """
  @spec extract_ranks([poker_hand]) :: [poker_hand]
  def extract_ranks(hand) do
    hand
    |> Enum.map(&split_rank_suit(&1))
    |> Enum.map(fn {rank, _suit} -> rank end)
  end

  @spec sort_cards([poker_hand]) :: [poker_hand]
  def sort_cards(hand) do
    hand
    |> Enum.sort(fn card1, card2 ->
      {r1, _} = split_rank_suit(card1)
      {r2, _} = split_rank_suit(card2)
      @card_rank[r1] < @card_rank[r2]
    end)
  end

  @spec split_rank_suit(String.t()) :: {String.t(), String.t()}
  def split_rank_suit(card) do
    case card do
      "10" <> s -> {"10", s}
      <<r::binary-size(1), s::binary>> -> {r, s}
    end
  end

  @doc """
  Classify a poker hand into a poker rank
  """
  @spec classify(poker_hand) :: {atom, poker_hand}
  def classify(hand) do
    cards =
      hand
      |> sort_cards
      |> Enum.map(&split_rank_suit(&1))

    case cards do
      [{r, _}, {r, _}, {r, _}, {r, _}, _] ->
        {:four_of_a_kind, hand}
      [_, {r, _}, {r, _}, {r, _}, {r, _}] ->
        {:four_of_a_kind, hand}
      [{r, _}, {r, _}, {r, _}, {r2, _}, {r2, _}] ->
        {:full_house, hand}
      [{r2, _}, {r2, _}, {r, _}, {r, _}, {r, _}] ->
        {:full_house, hand}
      [{_, s}, {_, s}, {_, s}, {_, s}, {_, s}] ->
        case is_straight?(hand) do
          true ->
            {:straight_flush, hand}
          false ->
            {:flush, hand}
        end
      [{r, _}, {r, _}, {r, _}, _, _] ->
        {:three_of_a_kind, hand}
      [_, {r, _}, {r, _}, {r, _}, _] ->
        {:three_of_a_kind, hand}
      [_, _, {r, _}, {r, _}, {r, _}] ->
        {:three_of_a_kind, hand}
      [{r, _}, {r, _}, {r2, _}, {r2, _}, _] ->
        {:two_pairs, hand}
      [{r, _}, {r, _}, _, {r2, _}, {r2, _}] ->
        {:two_pairs, hand}
      [_, {r, _}, {r, _}, {r2, _}, {r2, _}] ->
        {:two_pairs, hand}
      [{r, _}, {r, _}, _, _, _] ->
        {:one_pair, hand}
      [_, {r, _}, {r, _}, _, _] ->
        {:one_pair, hand}
      [_, _, {r, _}, {r, _}, _] ->
        {:one_pair, hand}
      [_, _, _, {r, _}, {r, _}] ->
        {:one_pair, hand}
      _ ->
        cond do
          is_straight?(hand) ->
            {:straight, hand}
          true ->
            {:high_card, hand}
        end
    end
  end

  @spec is_straight?(poker_hand) :: boolean
  def is_straight?(hand) do
    straights =
      ~w(A 2 3 4 5 6 7 8 9 10 J Q K A)
      |> Enum.chunk_every(5, 1, :discard)
      |> Enum.map(&MapSet.new(&1))

    hand =
      hand
      |> Enum.map(fn card ->
        {r, _} = split_rank_suit(card)
        r
      end)
      |> MapSet.new

    hand in straights
  end
end

