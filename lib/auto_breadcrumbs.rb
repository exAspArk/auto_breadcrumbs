require 'auto_breadcrumbs/version'

module AutoBreadcrumbs
  extend ActiveSupport::Concern

  included do
    include AutoBreadcrumbs::Controller
  end
end
