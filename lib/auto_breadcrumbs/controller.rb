require 'breadcrumbs_on_rails'

module AutoBreadcrumbs
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :add_breadcrumb_on_action, except: :destroy
    end

    private

    def add_breadcrumb_on_action(options = {})
      add_breadcrumb breadcrumbs_t('root'), :root_path

      unless request.path == root_path
        add_breadcrumb(index_translation, controllers_index_path) if controllers_index_path
        add_breadcrumb(action_translation) unless params[:action] == 'index'
      end
    end

    def index_translation
      breadcrumbs_t("controllers.#{ params[:controller] }.index")
    end

    def action_translation
      begin
        breadcrumbs_t!("controllers.#{ params[:controller] }.#{ breadcrumbs_action_name }")
      rescue I18n::MissingTranslationData
        breadcrumbs_t("actions.#{ breadcrumbs_action_name }")
      end
    end

    def controllers_index_path
      url_for(controller: params[:controller]) rescue nil
    end

    def breadcrumbs_action_name
      case params[:action]
      when 'create'
        'new'
      when 'update'
        'edit'
      else
        params[:action]
      end
    end

    def breadcrumbs_t(path)
      I18n.t('auto_breadcrumbs.' << path)
    end

    def breadcrumbs_t!(path)
      I18n.t!('auto_breadcrumbs.' << path)
    end
  end
end
