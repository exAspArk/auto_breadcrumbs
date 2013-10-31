module AutoBreadcrumbs
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../', __FILE__)

      desc 'Copy locale files to your application.'

      def copy_locale
        copy_file 'config/locales/en.yml', 'config/locales/auto_breadcrumbs.en.yml'
      end
    end
  end
end
