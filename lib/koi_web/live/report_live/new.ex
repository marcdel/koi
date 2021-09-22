defmodule KoiWeb.ReportLive.New do
  use KoiWeb, :live_view

  alias Koi.Accounts
  alias Koi.WaterQuality
  alias Koi.WaterQuality.Report
  alias Koi.WaterQuality.TestResult

  @impl true
  def mount(_params, session, socket) do
    socket = assign(socket, :user, current_user(session))

    {:ok, socket}
  end

  @impl true
  def handle_params(_, _, socket) do
    report = %Report{
      date: Date.utc_today(),
      user_id: user_id(socket),
      test_results: [%TestResult{}]
    }

    changeset =
      report
      |> WaterQuality.change_report()
#      |> Ecto.Changeset.put_assoc(:test_results, [%TestResult{}])

    {:noreply,
     socket
     |> assign(:page_title, "New Report")
     |> assign(:changeset, changeset)
     |> assign(:report, report)}
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
