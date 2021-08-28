defmodule KoiWeb.PageController do
  use KoiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
