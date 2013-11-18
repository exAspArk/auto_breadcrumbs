class UserPage < Struct.new(:paths)
  include Capybara::DSL

  def visit_index
    visit paths[:index]
    self
  end
end
