defmodule Koi.WaterQuality.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :date, :date
    field :notes, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:date, :notes])
    |> validate_required([:date, :notes])
  end
end
