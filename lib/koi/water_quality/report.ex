defmodule Koi.WaterQuality.Report do
  use Ecto.Schema
  import Ecto.Changeset

  alias Koi.Accounts.User
  alias Koi.WaterQuality.TestResult

  schema "reports" do
    field :date, :date
    field :notes, :string
    belongs_to :user, User
    has_many :test_results, TestResult

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:date, :notes, :user_id])
    |> cast_assoc(:test_results, with: &TestResult.changeset/2)
    |> validate_required([:date, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
