require 'breadcrumbs_on_rails'

module AutoBreadcrumbs
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :add_breadcrumb_on_action, except: :destroy

      helper_method :resource_translation
      helper_method :action_translation
    end

    private

    def add_breadcrumb_on_action(options = {})
      add_breadcrumb breadcrumbs_t('root'), :root_path

      unless request.path == root_path
        add_breadcrumb(resource_translation, index_path) if index_path
        add_breadcrumb(action_translation) unless params[:action] == 'index'
      end
    end

    def resource_translation
      breadcrumbs_t("controllers.#{ params[:controller] }.index") ||
      params[:controller].humanize
    end

    def action_translation
      breadcrumbs_t("controllers.#{ params[:controller] }.#{ breadcrumbs_action_name }") ||
      breadcrumbs_t("actions.#{ breadcrumbs_action_name }") ||
      breadcrumbs_action_name.humanize
    end

    def index_path
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
      I18n.t('auto_breadcrumbs.' << path, default: '').presence
    end
  end
end
