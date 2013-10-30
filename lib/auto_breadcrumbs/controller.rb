module AutoBreadcrumbs
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :add_breadcrumb_on_action
    end

    private

    def add_breadcrumb_on_action(options = {})
      add_breadcrumb I18n.t('breadcrumbs.resources.root'), :root_path

      unless request.path == root_path
        add_breadcrumb I18n.t("breadcrumbs.resources.#{ params[:controller] }"), controllers_index_path
        unless params[:action] == 'index'
          add_breadcrumb I18n.t("breadcrumbs.actions.#{ breadcrumbs_action_name }")
        end
      end
    end

    def controllers_index_path
      url_for controller: params[:controller]
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
  end
end
