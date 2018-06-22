defmodule YNABLoader.Category do
  defstruct [:name, :group, :budgeted, :balance, :activity]
  def from_json(%{
    "name" => name,
    "group" => group,
    "budgeted" => budgeted,
    "balance" => balance,
    "activity" => activity}
  ) do

    %__MODULE__{
      name: name,
      group: group,
      budgeted: normalize_currency(budgeted),
      balance: normalize_currency(balance),
      activity: normalize_currency(activity),
    }
  end

  def balanced?(%__MODULE__{
    activity: activity,
    budgeted: budgeted,
    balance: balance
  }) do
    activity + budgeted == balance
  end

  def activity?(%__MODULE__{activity: 0}), do: false
  def activity?(_), do: true

  def empty?(%{balance: 0}), do: true
  def empty?(_), do: false

  defp normalize_currency(int) do
    div(int, 10)
  end
end
