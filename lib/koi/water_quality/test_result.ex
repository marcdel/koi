defmodule Koi.WaterQuality.TestResult do
  use Ecto.Schema
  import Ecto.Changeset

  schema "test_results" do
    field :test_type, :string
    field :value, :decimal
    field :report_id, :id

    timestamps()
  end

  @doc false
  def changeset(test_result, attrs) do
    test_result
    |> cast(attrs, [:test_type, :value])
    |> validate_required([:test_type, :value])
  end
end
