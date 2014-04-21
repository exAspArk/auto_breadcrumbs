require 'spec_helper'
require 'features/pages/breadcrumb_page'

feature 'Rendering breadcrumbs' do
  let(:locale) do
    locale_file = File.open(Rails.root.join('config/locales/auto_breadcrumbs.en.yml'))
    YAML.load(locale_file)['en']['auto_breadcrumbs']
  end

  let(:root_breadcrumbs) { ['Home'] }

  scenario 'on root page' do
    root_page = BreadcrumbPage.new(index: root_path)

    root_page.visit_page(:index)

    expect(root_page.breadcrumbs).to eq(root_breadcrumbs)
  end

  scenario 'without translation' do
    country_name_page = BreadcrumbPage.new(index: country_names_path)

    country_name_page.visit_page(:index)
    country_name_index_breadcrumbs = root_breadcrumbs + ['Country names']

    expect(country_name_page.breadcrumbs).to eq(country_name_index_breadcrumbs)
  end

  scenario 'when resource without index action' do
    city_page = BreadcrumbPage.new(edit: edit_city_path('id'), show: city_path('id'))

    city_page.visit_page(:edit)
    city_edit_breadcrumbs = root_breadcrumbs + ['Cities & Towns', 'Edit']

    expect(city_page.breadcrumbs).to eq(city_edit_breadcrumbs)

    city_page.visit_page(:show)
    city_show_breadcrumbs = root_breadcrumbs + ['Cities & Towns', 'Browse']

    expect(city_page.breadcrumbs).to eq(city_show_breadcrumbs)
  end

  scenario 'when resource with index action' do
    user_page = BreadcrumbPage.new(
      index: users_path,
      show:  user_path('id'),
      edit:  edit_user_path('id'),
      dup:   dup_user_path('id'),
      ban:   ban_user_path('id'),
      sync:  sync_users_path
    )

    user_page.visit_page(:index)
    user_index_breadcrumbs = root_breadcrumbs + ['Users']

    expect(user_page.breadcrumbs).to eq(user_index_breadcrumbs)

    user_page.visit_page(:show)
    user_show_breadcrumbs = user_index_breadcrumbs + ['Show']

    expect(user_page.breadcrumbs).to eq(user_show_breadcrumbs)

    user_page.visit_page(:edit)
    user_edit_breadcrumbs = user_index_breadcrumbs + ['Settings']

    expect(user_page.breadcrumbs).to eq(user_edit_breadcrumbs)

    user_page.visit_page(:dup)
    user_dup_breadcrumbs = user_index_breadcrumbs + ['Duplication']

    expect(user_page.breadcrumbs).to eq(user_dup_breadcrumbs)

    user_page.visit_page(:sync)
    user_sync_breadcrumbs = user_index_breadcrumbs + ['Synchronization']

    expect(user_page.breadcrumbs).to eq(user_sync_breadcrumbs)

    user_page.visit_page(:ban)
    user_ban_breadcrumbs = user_index_breadcrumbs + ['Ban']

    expect(user_page.breadcrumbs).to eq(user_ban_breadcrumbs)
  end

  scenario 'nested resources' do
    nested_user_page = BreadcrumbPage.new(show: city_user_path('city_id', 'id'))

    nested_user_page.visit_page(:show)
    nested_breadcrumbs = root_breadcrumbs + ['Cities & Towns', 'Browse', 'Users', 'Show']

    expect(nested_user_page.breadcrumbs).to eq(nested_breadcrumbs)
  end
end
