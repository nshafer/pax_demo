defmodule PaxDemoWeb.Router do
  use PaxDemoWeb, :router
  use Pax.Admin.Router
  import LiveAdmin.Router

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

    pax_admin "/admin", MainAdmin.Site, as: :admin
    pax_admin "/partner/admin", PartnerAdmin.PrivateSite
    pax_admin "/public/admin", PartnerAdmin.PublicSite

    live_admin "/live_admin" do
      admin_resource("/labels", PaxDemoWeb.LiveAdmin.LabelResource)
      admin_resource("/artists", PaxDemoWeb.LiveAdmin.ArtistResource)
      admin_resource("/albums", PaxDemoWeb.LiveAdmin.AlbumResource)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PaxDemoWeb do
  #   pipe_through :api
  # end
end
