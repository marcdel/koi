defmodule KoiWeb.ReportLive.FormComponent do
  use KoiWeb, :live_component

  alias Koi.WaterQuality

  @impl true
  def update(%{report: report} = assigns, socket) do
    changeset = WaterQuality.change_report(report)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"report" => report_params}, socket) do
    changeset =
      socket.assigns.report
      |> WaterQuality.change_report(report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"report" => report_params}, socket) do
    save_report(socket, socket.assigns.action, report_params)
  end

  defp save_report(socket, :edit, report_params) do
    case WaterQuality.update_report(socket.assigns.report, report_params) do
      {:ok, _report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Report updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_report(socket, :new, report_params) do
    case WaterQuality.create_report(report_params) do
      {:ok, _report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Report created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
