defmodule PaxDemoWeb.Router do
  use PaxDemoWeb, :router
  use Pax.Admin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PaxDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PaxDemoWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/labels", LabelLive.Index, :index
    live "/labels/new", LabelLive.Detail, :new
    live "/labels/:id", LabelLive.Detail, :show
    live "/labels/:id/edit", LabelLive.Detail, :edit
    live "/labels/:id/delete", LabelLive.Detail, :delete
  end

  pipeline :admin do
    plug :put_root_layout, html: {Pax.Admin.Layouts, :root}
  end

  scope "/", PaxDemoWeb do
    pipe_through [:browser, :admin]

    pax_admin "/admin", Admin
  end

  # Other scopes may use custom stacks.
  # scope "/api", PaxDemoWeb do
  #   pipe_through :api
  # end
end
