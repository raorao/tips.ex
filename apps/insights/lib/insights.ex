defmodule Insights do
  @moduledoc """
  Documentation for Insights.
  """

  def generate(categories, progress_into_month \\ progress_into_month()) do
    insights = for type <- insight_types(), category <- categories do
      type.run(category, progress_into_month)
    end

    insights
    |> Enum.filter(& &1)
    |> Enum.filter(& elem(&1, 1) > 10)

  end

  def progress_into_month() do
    current_date = DateTime.utc_now

    last_day = :calendar.last_day_of_the_month(current_date.year, current_date.month)

    current_date.day / last_day
  end

  defp insight_types() do
    [
      Insights.Progress
    ]
  end
end
