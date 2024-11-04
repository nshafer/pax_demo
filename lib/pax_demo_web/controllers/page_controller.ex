defmodule PaxDemoWeb.PageController do
  use PaxDemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
