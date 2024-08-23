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

    live "/labels", LabelLive, :index
    live "/labels/new", LabelLive, :new
    live "/labels/:id", LabelLive, :show
    live "/labels/:id/edit", LabelLive, :edit
    live "/labels/:id/delete", LabelLive, :delete

    live "/artists", ArtistLive, :index
    live "/artists/new", ArtistLive, :new
    live "/artists/:id", ArtistLive, :show
    live "/artists/:id/edit", ArtistLive, :edit
    live "/artists/:id/delete", ArtistLive, :delete

    live "/albums", AlbumLive, :index
    live "/albums/new", AlbumLive, :new
    live "/albums/:id", AlbumLive, :show
    live "/albums/:id/edit", AlbumLive, :edit
    live "/albums/:id/delete", AlbumLive, :delete
  end

  scope "/", PaxDemoWeb do
    pipe_through [:browser]

    pax_admin "/admin", MainAdmin.Site, as: :admin
    pax_admin "/partner/admin", PartnerAdmin.PrivateSite
    pax_admin "/public/admin", PartnerAdmin.PublicSite
  end

  scope "/", PaxDemoWeb do
    pipe_through [:browser]

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
