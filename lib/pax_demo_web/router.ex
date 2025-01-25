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

    live "/books", BookLive, :index
    live "/books/new", BookLive, :new
    live "/books/:id/:slug", BookLive, :show
    live "/books/:id/:slug/edit", BookLive, :edit
    live "/books/:id/:slug/delete", BookLive, :delete

    live "/authors", AuthorLive, :index
    live "/authors/new", AuthorLive, :new
    live "/authors/:id/:name", AuthorLive, :show
    live "/authors/:id/:name/edit", AuthorLive, :edit
    live "/authors/:id/:name/delete", AuthorLive, :delete
  end

  scope "/admin", PaxDemoWeb do
    pipe_through [:browser]

    pax_admin "/", Admin.Site
  end

  # Other scopes may use custom stacks.
  # scope "/api", PaxDemoWeb do
  #   pipe_through :api
  # end
end
