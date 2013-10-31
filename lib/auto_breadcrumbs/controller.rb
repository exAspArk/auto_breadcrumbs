module AutoBreadcrumbs
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :add_breadcrumb_on_action, except: :destroy
    end

    private

    def add_breadcrumb_on_action(options = {})
      add_breadcrumb I18n.t('breadcrumbs.root'), :root_path

      unless request.path == root_path
        add_breadcrumb index_translation, controllers_index_path
        unless params[:action] == 'index'
          add_breadcrumb action_translation
        end
      end
    end

    def index_translation
      I18n.t("breadcrumbs.controllers.#{ params[:controller] }.index")
    end

    def action_translation
      begin
        I18n.t!("breadcrumbs.controllers.#{ params[:controller] }.#{ breadcrumbs_action_name }")
      rescue I18n::MissingTranslationData
        I18n.t("breadcrumbs.actions.#{ breadcrumbs_action_name }")
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
