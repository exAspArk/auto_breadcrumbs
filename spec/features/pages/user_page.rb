class UserPage < Struct.new(:path)
  include Capybara::DSL

  def visit_page
    visit path
    self
  end
end
