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
        user_id: user_id,
        test_results: []
      })
      |> Koi.WaterQuality.create_report()

    report
    |> Koi.Repo.preload(:test_results)
  end

  @doc """
  Generate a test_result.
  """
  def test_result_fixture(attrs \\ %{}) do
    %{id: report_id} = report_fixture()

    {:ok, test_result} =
      attrs
      |> Enum.into(%{
        test_type: "some test_type",
        value: "120.5",
        report_id: report_id
      })
      |> Koi.WaterQuality.create_test_result()

    test_result
  end
end
