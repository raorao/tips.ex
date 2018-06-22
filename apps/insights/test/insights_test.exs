defmodule InsightsTest do
  use ExUnit.Case
  doctest Insights

  test "returns insights based on progress" do
    category = %YNABLoader.Category{
      name: "Apparel",
      group: "True Expenses",
      budgeted: 10000,
      balance: 9342,
      activity: -658
    }
    categories = [ category ]

    progress_into_month = 0.37

    expected = [
      {:underspent, 30.42, category.name}
    ]

    assert Insights.generate(categories, progress_into_month) == expected
  end
end
