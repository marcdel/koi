defmodule KoiWeb.ReportLiveTest do
  use KoiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Koi.WaterQualityFixtures

  @create_attrs %{date: %{day: 11, month: 9, year: 2021}, notes: "some notes"}
  @update_attrs %{date: %{day: 12, month: 9, year: 2021}, notes: "some updated notes"}
  @invalid_attrs %{date: %{day: 31, month: 11, year: 2021}}

  defp create_report(%{user: user}) do
    # use the user from :register_and_log_in_user
    report = report_fixture(%{user_id: user.id})
    %{report: report}
  end

  setup :register_and_log_in_user

  describe "Index" do
    setup [:create_report]

    test "lists all reports", %{conn: conn, report: report} do
      {:ok, _index_live, html} = live(conn, Routes.report_index_path(conn, :index))

      assert html =~ "Listing Reports"
      assert html =~ report.notes
    end

    test "saves new report", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.report_index_path(conn, :index))

      assert index_live |> element("a", "New Report") |> render_click() =~
               "New Report"

      assert_patch(index_live, Routes.report_new_path(conn, :new))

      assert index_live
             |> form("#report-form", report: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#report-form", report: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.report_index_path(conn, :index))

      assert html =~ "Report created successfully"
      assert html =~ "some notes"
    end

    test "updates report in listing", %{conn: conn, report: report} do
      {:ok, index_live, _html} = live(conn, Routes.report_index_path(conn, :index))

      #      assert index_live |> element("#report-#{report.id} a", "Edit") |> render_click() =~
      #               "Edit Report"
      index_live |> element("#report-#{report.id} a", "Edit") |> render_click()

      assert_patch(index_live, Routes.report_edit_path(conn, :edit, report))

      assert index_live
             |> form("#report-form", report: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#report-form", report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.report_index_path(conn, :index))

      assert html =~ "Report updated successfully"
      assert html =~ "some updated notes"
    end

    test "deletes report in listing", %{conn: conn, report: report} do
      {:ok, index_live, _html} = live(conn, Routes.report_index_path(conn, :index))

      assert index_live |> element("#report-#{report.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#report-#{report.id}")
    end
  end

  describe "Show" do
    setup [:create_report]

    test "displays report", %{conn: conn, report: report} do
      {:ok, _show_live, html} = live(conn, Routes.report_show_path(conn, :show, report))

      assert html =~ "Show Report"
      assert html =~ report.notes
    end

    test "updates report within modal", %{conn: conn, report: report} do
      {:ok, show_live, _html} = live(conn, Routes.report_show_path(conn, :show, report))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Report"

      assert_patch(show_live, Routes.report_show_path(conn, :edit, report))

      assert show_live
             |> form("#report-form", report: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#report-form", report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.report_show_path(conn, :show, report))

      assert html =~ "Report updated successfully"
      assert html =~ "some updated notes"
    end
  end
end
