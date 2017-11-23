defmodule Allergies do
  use Bitwise

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    allergens = ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]
    for allergen <- allergens, allergic_to?(flags, allergen), do: allergen
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    case item do
      "eggs" -> (flags &&& 1) != 0
      "peanuts" -> (flags &&& 2) != 0
      "shellfish" -> (flags &&& 4) != 0
      "strawberries" -> (flags &&& 8) != 0
      "tomatoes" -> (flags &&& 16) != 0
      "chocolate" -> (flags &&& 32) != 0
      "pollen" -> (flags &&& 64) != 0
      "cats" -> (flags &&& 128) != 0
    end
  end
end
