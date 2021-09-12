defmodule Koi.WaterQualityFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Koi.WaterQuality` context.
  """

  import Koi.AccountsFixtures

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    %{id: user_id} = user_fixture()

    {:ok, report} =
      attrs
      |> Enum.into(%{
        date: ~D[2021-09-11],
        notes: "some notes",
        user_id: user_id
      })
      |> Koi.WaterQuality.create_report()

    report
  end
end
