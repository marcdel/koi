defmodule Koi.WaterQuality.TestResult do
  use Ecto.Schema
  import Ecto.Changeset

  alias Koi.WaterQuality.Report

  schema "test_results" do
    field :test_type, :string
    field :value, :decimal
    belongs_to :report, Report

    timestamps()
  end

  @doc false
  def changeset(test_result, attrs) do
    test_result
    |> cast(attrs, [:test_type, :value, :report_id])
    |> validate_required([:test_type, :value])
  end
end
