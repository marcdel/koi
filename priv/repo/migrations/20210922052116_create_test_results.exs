defmodule Koi.Repo.Migrations.CreateTestResults do
  use Ecto.Migration

  def change do
    create table(:test_results) do
      add :test_type, :string
      add :value, :decimal
      add :report_id, references(:reports, on_delete: :nothing)

      timestamps()
    end

    create index(:test_results, [:report_id])
  end
end
