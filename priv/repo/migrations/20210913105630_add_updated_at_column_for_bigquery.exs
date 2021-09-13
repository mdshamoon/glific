defmodule Glific.Repo.Migrations.AddUpdatedAtColumnForBigquery do
  use Ecto.Migration

  def change do
    alter table(:bigquery_jobs) do
      add :last_updated_at, :utc_datetime_usec, null: false,
      comment: "Last updated timestamp for a bigquery jobs"
    end
  end
end
