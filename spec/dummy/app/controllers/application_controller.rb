class ApplicationController < ActionController::Base
  include AutoBreadcrumbs

  before_filter -> { render 'shared/blank_page' }
end
