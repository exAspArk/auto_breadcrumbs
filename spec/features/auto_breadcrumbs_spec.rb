require 'spec_helper'
require 'features/pages/user_page'

feature AutoBreadcrumbs do
  let(:locale) { YAML.load(File.open(Rails.root.join('config/locales/auto_breadcrumbs.en.yml')))['en']['auto_breadcrumbs'] }

  let(:root_breadcrumbs)  { [locale['root']] }
  let(:index_breadcrumbs) { root_breadcrumbs  + [locale['controllers']['users']['index']] }
  let(:show_breadcrumbs)  { index_breadcrumbs + [locale['actions']['show']] }
  let(:edit_breadcrumbs)  { index_breadcrumbs + [locale['controllers']['users']['edit']] }
  let(:dup_breadcrumbs)   { index_breadcrumbs + [locale['controllers']['users']['dup']] }
  let(:sync_breadcrumbs)  { index_breadcrumbs + [locale['controllers']['users']['sync']] }

  let(:user_page) {
    UserPage.new index: users_path,
                 show:  user_path('id'),
                 edit:  edit_user_path('id'),
                 dup:   dup_user_path('id'),
                 sync:  sync_users_path
  }

  scenario 'breadcrumbs rendering' do
    visit root_path
    expect(user_page.breadcrumbs).to eq(root_breadcrumbs)

    user_page.visit_page(:index)
    expect(user_page.breadcrumbs).to eq(index_breadcrumbs)

    user_page.visit_page(:show)
    expect(user_page.breadcrumbs).to eq(show_breadcrumbs)

    user_page.visit_page(:edit)
    expect(user_page.breadcrumbs).to eq(edit_breadcrumbs)

    user_page.visit_page(:dup)
    expect(user_page.breadcrumbs).to eq(dup_breadcrumbs)

    user_page.visit_page(:sync)
    expect(user_page.breadcrumbs).to eq(sync_breadcrumbs)
  end
end
