defmodule KoiWeb.ReportLive.Index do
  use KoiWeb, :live_view

  alias Koi.WaterQuality
  alias Koi.WaterQuality.Report

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :reports, list_reports())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Report")
    |> assign(:report, WaterQuality.get_report!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Report")
    |> assign(:report, %Report{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reports")
    |> assign(:report, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    report = WaterQuality.get_report!(id)
    {:ok, _} = WaterQuality.delete_report(report)

    {:noreply, assign(socket, :reports, list_reports())}
  end

  defp list_reports do
    WaterQuality.list_reports()
  end
end
