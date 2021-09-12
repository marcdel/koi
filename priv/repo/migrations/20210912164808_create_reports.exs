defmodule Koi.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :date, :date
      add :notes, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:reports, [:user_id])
  end
end
