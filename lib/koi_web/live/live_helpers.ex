defmodule KoiWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `KoiWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal KoiWeb.ReportLive.FormComponent,
        id: @report.id || :new,
        action: @live_action,
        report: @report,
        return_to: Routes.report_index_path(@socket, :index) %>
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(KoiWeb.ModalComponent, modal_opts)
  end
end
