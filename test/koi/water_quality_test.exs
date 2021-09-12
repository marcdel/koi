defmodule Koi.WaterQualityTest do
  use Koi.DataCase

  alias Koi.WaterQuality

  describe "reports" do
    alias Koi.WaterQuality.Report

    import Koi.WaterQualityFixtures

    @invalid_attrs %{date: nil, notes: nil}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert WaterQuality.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert WaterQuality.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{date: ~D[2021-09-11], notes: "some notes"}

      assert {:ok, %Report{} = report} = WaterQuality.create_report(valid_attrs)
      assert report.date == ~D[2021-09-11]
      assert report.notes == "some notes"
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WaterQuality.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{date: ~D[2021-09-12], notes: "some updated notes"}

      assert {:ok, %Report{} = report} = WaterQuality.update_report(report, update_attrs)
      assert report.date == ~D[2021-09-12]
      assert report.notes == "some updated notes"
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = WaterQuality.update_report(report, @invalid_attrs)
      assert report == WaterQuality.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = WaterQuality.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> WaterQuality.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = WaterQuality.change_report(report)
    end
  end
end
