defmodule Koi.WaterQualityFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Koi.WaterQuality` context.
  """

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    {:ok, report} =
      attrs
      |> Enum.into(%{
        date: ~D[2021-09-11],
        notes: "some notes"
      })
      |> Koi.WaterQuality.create_report()

    report
  end
end
