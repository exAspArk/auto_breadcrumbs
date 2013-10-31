require 'auto_breadcrumbs/version'
require 'auto_breadcrumbs/controller'

module AutoBreadcrumbs
  extend ActiveSupport::Concern

  included do
    include AutoBreadcrumbs::Controller
  end
end
