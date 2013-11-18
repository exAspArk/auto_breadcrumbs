class UserPage < Struct.new(:paths)
  include Capybara::DSL

  def visit_page(path)
    visit paths[path]
  end

  def breadcrumbs
    find('body').text.split('/')
  end
end
