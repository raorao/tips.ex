defmodule YNABLoader.ApiClient do
  def categories(token, budget_id) do
    url = "https://api.youneedabudget.com/v1/budgets/#{budget_id}/categories?access_token=#{token}"

    %HTTPoison.Response{body: body} = HTTPoison.get! url
    Poison.decode! body
  end
end
