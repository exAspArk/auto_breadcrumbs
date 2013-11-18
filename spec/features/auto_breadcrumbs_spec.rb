require 'spec_helper'
require 'features/pages/breadcrumb_page'

feature AutoBreadcrumbs do
  let(:locale) { YAML.load(File.open(Rails.root.join('config/locales/auto_breadcrumbs.en.yml')))['en']['auto_breadcrumbs'] }

  let(:root_breadcrumbs) { [locale['root']] }

  let(:user_page) {
    BreadcrumbPage.new index: users_path,
                       show:  user_path('id'),
                       edit:  edit_user_path('id'),
                       dup:   dup_user_path('id'),
                       sync:  sync_users_path
  }
  let(:user_index_breadcrumbs) { root_breadcrumbs  + [locale['controllers']['users']['index']] }
  let(:user_show_breadcrumbs)  { user_index_breadcrumbs + [locale['actions']['show']] }
  let(:user_edit_breadcrumbs)  { user_index_breadcrumbs + [locale['controllers']['users']['edit']] }
  let(:user_dup_breadcrumbs)   { user_index_breadcrumbs + [locale['controllers']['users']['dup']] }
  let(:user_sync_breadcrumbs)  { user_index_breadcrumbs + [locale['controllers']['users']['sync']] }

  let(:city_page) {
    BreadcrumbPage.new edit: edit_city_path('id'),
                       show: city_path('id')
  }
  let(:city_edit_breadcrumbs) { root_breadcrumbs + [locale['actions']['edit']] }
  let(:city_show_breadcrumbs) { root_breadcrumbs + [locale['controllers']['cities']['show']] }

  scenario 'breadcrumbs rendering' do
    visit root_path
    expect(user_page.breadcrumbs).to eq(root_breadcrumbs)

    # ---------------------------------------------------------------

    user_page.visit_page(:index)
    expect(user_page.breadcrumbs).to eq(user_index_breadcrumbs)

    user_page.visit_page(:show)
    expect(user_page.breadcrumbs).to eq(user_show_breadcrumbs)

    user_page.visit_page(:edit)
    expect(user_page.breadcrumbs).to eq(user_edit_breadcrumbs)

    user_page.visit_page(:dup)
    expect(user_page.breadcrumbs).to eq(user_dup_breadcrumbs)

    user_page.visit_page(:sync)
    expect(user_page.breadcrumbs).to eq(user_sync_breadcrumbs)

    # ---------------------------------------------------------------

    city_page.visit_page(:edit)
    expect(city_page.breadcrumbs).to eq(city_edit_breadcrumbs)

    city_page.visit_page(:show)
    expect(city_page.breadcrumbs).to eq(city_show_breadcrumbs)
  end
end
