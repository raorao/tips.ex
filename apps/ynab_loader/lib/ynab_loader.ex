defmodule YNABLoader do
  def categories(token, budget_id, api_client \\ YNABLoader.ApiClient) do
    api_client.categories(token, budget_id)
    |> parse_categories
  end

  defp parse_categories(raw_response) do
    raw_response
    |> Map.get("data")
    |> Map.get("category_groups")
    |> Enum.reject(& Map.get(&1, "name") == "Internal Master Category")
    |> Enum.flat_map(&parse_category/1)
    |> Enum.filter(&YNABLoader.Category.balanced?/1)
    |> Enum.filter(&YNABLoader.Category.activity?/1)
    |> Enum.reject(&YNABLoader.Category.empty?/1)

  end

  defp parse_category(%{"name" => group, "categories" => categories}) do
    mapperFn = fn (category) ->
      category
      |> Map.merge(%{"group" => group})
      |> YNABLoader.Category.from_json
    end

    categories
    |> Enum.reject(& Map.get(&1, "hidden"))
    |> Enum.map(mapperFn)
  end
end
