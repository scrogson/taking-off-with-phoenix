defmodule Support.Repo.Migrations.CreateIssue do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :title, :string
      add :description, :text
      add :closed, :boolean, default: false
      add :closed_at, :datetime
      add :user_id, references(:users)

      timestamps
    end
    create index(:issues, [:user_id])

  end
end
