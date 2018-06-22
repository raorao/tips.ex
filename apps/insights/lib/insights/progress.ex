defmodule Insights.Progress do
  def run(category, progress_in_month) do
    expected_activity = progress_in_month * category.budgeted
    activity = -category.activity

    diff = activity - expected_activity

    cond do
      diff > 0 ->
        {:overspent, to_dollars(diff), category.name}
      diff < 0 ->
        {:underspent, to_dollars(-diff), category.name}
      true -> nil
    end
  end

  defp to_dollars(float) do
    Float.round(float / 100.0, 2)
  end
end
