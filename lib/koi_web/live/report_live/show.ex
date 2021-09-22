defmodule KoiWeb.ReportLive.Show do
  use KoiWeb, :live_view

  alias Koi.WaterQuality

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Show Report")
     |> assign(:report, WaterQuality.get_report!(id))}
  end
end
