defmodule YNABLoaderTest do
  use ExUnit.Case
  doctest YNABLoader

  defmodule FakeApiClient do
    def categories(token, budget_id) do
      %{
        "data" => %{
          "category_groups" => [
            %{
              "categories" => [
                %{
                  "activity" => -6580,
                  "balance" => 93420,
                  "budgeted" => 100000,
                  "hidden" => false,

                  "category_group_id" => "cd607eb6-7c0a-42c2-92b9-2b48ad1ac907",
                  "id" => "c2e314d7-8c47-49a4-8ac0-f05a2d4c1794",
                  "name" => "Apparel",
                },
                %{
                  "activity" => 0,
                  "balance" => 0,
                  "budgeted" => 0,
                  "category_group_id" => "e014f6a7-08da-446d-b1a6-fb62bb175e90",
                  "deleted" => false,
                  "hidden" => true,
                  "id" => "172964e0-70ae-4957-b7d0-a31cd1f0ce7f",
                  "name" => "House Upkeep",
                  "note" => nil
                }
              ],
              "id" => "cd607eb6-7c0a-42c2-92b9-2b48ad1ac907",
              "name" => "True Expenses"
            },
            %{
              "categories" => [
                %{
                  "activity" => 5664280,
                  "balance" => 39696320,
                  "budgeted" => -2057240,
                  "category_group_id" => "fbe7dcfe-a9e9-4cca-b58f-d4bea492cf69",
                  "deleted" => false,
                  "hidden" => false,
                  "id" => "fa1a2c48-c02b-41b9-a197-7ccb7d0c022a",
                  "name" => "Immediate Income SubCategory",
                  "note" => nil
                },
              ],
              "deleted" => false,
              "hidden" => false,
              "id" => "fbe7dcfe-a9e9-4cca-b58f-d4bea492cf69",
              "name" => "Internal Master Category"
            }
          ]
        }
      }
    end
  end

  test "parses response" do
    expected = [
      %YNABLoader.Category{
        name: "Apparel",
        group: "True Expenses",
        budgeted: 10000,
        balance: 9342,
        activity: -658
      }
    ]

    assert YNABLoader.categories("token", "budget_id", FakeApiClient) == expected
  end
end
