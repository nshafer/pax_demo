defmodule PaxDemoWeb.Admin.Site do
  use Pax.Admin.Site, router: PaxDemoWeb.Router

  config title: "Pax Admin"

  resource :books, PaxDemoWeb.Admin.BookResource
  resource :authors, PaxDemoWeb.Admin.AuthorResource

  section :metadata do
    resource :subjects, PaxDemoWeb.Admin.SubjectResource
    resource :classifications, PaxDemoWeb.Admin.ClassificationResource
    resource :languages, PaxDemoWeb.Admin.LanguageResource
  end
end
