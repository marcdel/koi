defmodule KoiWeb.ReportLive.Index do
  use KoiWeb, :live_view

  alias Koi.Accounts
  alias Koi.WaterQuality
  alias Koi.WaterQuality.Report

  @impl true
  def mount(_params, session, socket) do
    socket = assign(socket, :user, current_user(session))
    socket = assign(socket, :reports, list_reports(socket))

    {:ok, socket}
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
    |> assign(:report, %Report{date: Date.utc_today(), user_id: user_id(socket)})
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

    {:noreply, assign(socket, :reports, list_reports(socket))}
  end

  defp list_reports(socket) do
    if user_id(socket) do
      WaterQuality.list_reports(socket.assigns.user.id)
    else
      []
    end
  end

  defp user_id(socket) do
    if Map.has_key?(socket.assigns, :user) do
      socket.assigns.user.id
    else
      nil
    end
  end

  defp current_user(session) do
    user_token = Map.get(session, "user_token")
    user_token && Accounts.get_user_by_session_token(user_token)
  end
end
