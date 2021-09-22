defmodule KoiWeb.ReportLive.TestSelectionComponent do
  use KoiWeb, :live_component

  alias Koi.WaterQuality
  alias Koi.WaterQuality.TestResult

  @impl true
  def update(%{report: report} = assigns, socket) do
    changeset = WaterQuality.change_report(report)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:test_types, ["", "pH", "Ammonia"])}
  end

  @impl true
  def handle_event("add_test", params, socket) do
    {:noreply, add_empty_test(params, socket)}
  end

  @impl true
  def handle_event("validate", params, socket) do
    IO.inspect(params, label: "validate params")
    {:noreply, socket}
  end

#  def handle_event("validate", %{"report" => report_params}, socket) do
#    changeset =
#      socket.assigns.report
#      |> WaterQuality.change_report(report_params)
#      |> Map.put(:action, :validate)
#      |> IO.inspect()
#
#    {:noreply, assign(socket, :changeset, changeset)}
#  end

#  def handle_event("save", %{"report" => report_params}, socket) do
#    {:noreply,
#      socket
#      |> push_redirect(to: Routes.report_index_path(socket, :index))}
#  end

  def handle_event("next", params, socket) do
    IO.inspect(params, label: "params")
    {:noreply,
      socket
      |> push_redirect(to: Routes.report_index_path(socket, :index))}
  end

  defp add_empty_test(params, socket) do
#    IO.inspect(%{params: params, socket: socket})
    report = socket.assigns.report

    prev_results = report.test_results
    report = %{report | test_results: prev_results ++ [%TestResult{}]}
    changeset = WaterQuality.change_report(report)
#    changeset = Ecto.Changeset.put_assoc(socket.assigns.changeset, :test_results, prev_results ++ [%TestResult{}])

    socket
    |> assign(:report, report)
    |> assign(:changeset, changeset)

#    prev_results = Map.get(socket.assigns.changeset.changes, :test_results, socket.assigns.report.test_results)
#    changeset = socket.assigns.changeset
#    changeset = Ecto.Changeset.put_assoc(changeset, :test_results, prev_results ++ [%TestResult{}])
#    |> IO.inspect(label: "changeset")
#    assign(socket, :changeset, changeset)
  end

#  defp save_report(socket, :new, report_params) do
#    case WaterQuality.create_report(report_params) do
#      {:ok, _report} ->
#        {:noreply,
#         socket
#         |> put_flash(:info, "Report created successfully")
#         |> push_redirect(to: socket.assigns.return_to)}
#
#      {:error, %Ecto.Changeset{} = changeset} ->
#        {:noreply, assign(socket, changeset: changeset)}
#    end
#  end
end
