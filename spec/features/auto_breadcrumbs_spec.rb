require 'spec_helper'
require 'features/pages/user_page'

feature AutoBreadcrumbs do
  let(:locale) { YAML.load(File.open(Rails.root.join('config/locales/en.yml')))['en']['auto_breadcrumbs'] }
  let(:user_page) { UserPage.new(index: users_path) }

  scenario 'breadcrumbs rendering', js: true do
    visit root_path
    expect(page).to have_content(locale['root'])

    user_page.visit_index
    expect(page).to have_content(locale['root'])
    expect(page).to have_content(locale['controllers']['users']['index'])
  end
end
