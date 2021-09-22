defmodule Koi.WaterQualityTest do
  use Koi.DataCase

  alias Koi.WaterQuality

  describe "reports" do
    alias Koi.WaterQuality.Report

    import Koi.AccountsFixtures
    import Koi.WaterQualityFixtures

    @invalid_attrs %{date: nil}

    test "list_reports/1 returns all reports for the given user" do
      report = report_fixture()
      assert WaterQuality.list_reports(report.user_id) == [report]
      assert WaterQuality.list_reports(report.user_id + 1) == []
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert WaterQuality.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      %{id: user_id} = user_fixture()

      valid_attrs = %{
        date: ~D[2021-09-11],
        notes: "some notes",
        user_id: user_id,
        test_results: [
          %{test_type: "pH", value: "120.5"},
          %{test_type: "ammonia", value: "0.0"}
        ]
      }

      assert {:ok, %Report{} = report} = WaterQuality.create_report(valid_attrs)
      assert report.date == ~D[2021-09-11]
      assert report.notes == "some notes"
      assert [%{test_type: "pH"} = ph, %{test_type: "ammonia"}] = report.test_results
      assert Decimal.equal?(ph.value, "120.5")
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

  describe "test_results" do
    alias Koi.WaterQuality.TestResult

    import Koi.WaterQualityFixtures

    @invalid_attrs %{test_type: nil, value: nil}

    test "list_test_results/0 returns all test_results" do
      test_result = test_result_fixture()
      assert WaterQuality.list_test_results() == [test_result]
    end

    test "get_test_result!/1 returns the test_result with given id" do
      test_result = test_result_fixture()
      assert WaterQuality.get_test_result!(test_result.id) == test_result
    end

    test "create_test_result/1 with valid data creates a test_result" do
      %{id: report_id} = report_fixture()
      valid_attrs = %{test_type: "some test_type", value: "120.5", report_id: report_id}

      assert {:ok, %TestResult{} = test_result} = WaterQuality.create_test_result(valid_attrs)
      assert test_result.test_type == "some test_type"
      assert test_result.value == Decimal.new("120.5")
    end

    test "create_test_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WaterQuality.create_test_result(@invalid_attrs)
    end

    test "update_test_result/2 with valid data updates the test_result" do
      test_result = test_result_fixture()
      update_attrs = %{test_type: "some updated test_type", value: "456.7"}

      assert {:ok, %TestResult{} = test_result} =
               WaterQuality.update_test_result(test_result, update_attrs)

      assert test_result.test_type == "some updated test_type"
      assert test_result.value == Decimal.new("456.7")
    end

    test "update_test_result/2 with invalid data returns error changeset" do
      test_result = test_result_fixture()

      assert {:error, %Ecto.Changeset{}} =
               WaterQuality.update_test_result(test_result, @invalid_attrs)

      assert test_result == WaterQuality.get_test_result!(test_result.id)
    end

    test "delete_test_result/1 deletes the test_result" do
      test_result = test_result_fixture()
      assert {:ok, %TestResult{}} = WaterQuality.delete_test_result(test_result)
      assert_raise Ecto.NoResultsError, fn -> WaterQuality.get_test_result!(test_result.id) end
    end

    test "change_test_result/1 returns a test_result changeset" do
      test_result = test_result_fixture()
      assert %Ecto.Changeset{} = WaterQuality.change_test_result(test_result)
    end
  end
end
