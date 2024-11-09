defmodule PaxDemoWeb.Admin.Site do
  use Pax.Admin.Site, router: PaxDemoWeb.Router

  config title: "Pax Demo Admin"

  resource :books, PaxDemoWeb.Admin.BookResource, label: "Book List"
  resource :authors, PaxDemoWeb.Admin.AuthorResource

  section :metadata, label: "Metadata" do
    resource :subjects, PaxDemoWeb.Admin.SubjectResource
    resource :classifications, PaxDemoWeb.Admin.ClassificationResource
    resource :languages, PaxDemoWeb.Admin.LanguageResource
  end
end
