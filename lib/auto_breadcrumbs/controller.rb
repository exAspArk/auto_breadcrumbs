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
        # nested resources
        Rails.application.routes.router.recognize(request) do |route, matches, param|
          route.required_parts[0...-1].each do |required_part|
            resources_name              = required_part.to_s.gsub('_id', '').pluralize
            resource_index_path         = index_path(resources_name)
            nested_resource_translation = resource_translation(resources_name)
            nested_action_translation   = action_translation(resources_name, 'show')

            add_breadcrumb(nested_resource_translation, resource_index_path) if nested_resource_translation
            add_breadcrumb(nested_action_translation)                        if nested_action_translation
          end
        end

        resource_index_path = index_path(params[:controller])
        add_breadcrumb(resource_translation, resource_index_path) if resource_translation
        add_breadcrumb(action_translation)                        if action_translation
      end
    end

    def resource_translation(resources_name = nil)
      resources_name ||= params[:controller]

      if index_path(resources_name)
        breadcrumbs_t("controllers.#{ resources_name }.index") ||
        resources_name.humanize
      end
    end

    def action_translation(resources_name = nil, action_name = nil)
      resources_name ||= params[:controller]
      action_name ||= params[:action]

      mapped_action_name = breadcrumbs_action_name(action_name)

      unless mapped_action_name == 'index'
        breadcrumbs_t("controllers.#{ resources_name }.#{ mapped_action_name }") ||
        breadcrumbs_t("actions.#{ mapped_action_name }") ||
        mapped_action_name.humanize
      end
    end

    def index_path(resources_name)
      url_for(controller: resources_name) rescue nil
    end

    def breadcrumbs_action_name(action_name)
      case action_name
      when 'create'
        'new'
      when 'update'
        'edit'
      else
        action_name
      end
    end

    def breadcrumbs_t(path)
      I18n.t('auto_breadcrumbs.' << path, default: '').presence
    end
  end
end
