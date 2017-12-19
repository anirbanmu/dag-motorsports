module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-dismissible fade in" role="alert">
      <button type="button" class="close" data-dismiss="alert">
        <span aria-hidden="true">&times;</span>
      </button>
      <strong>
       #{pluralize(resource.errors.count, "error")} must be fixed
      </strong>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def translate_devise_alert_to_bootstrap(key)
    return 'info' if key == 'notice'
    return 'danger' if key == 'error'
    return 'danger' if key == 'alert'
    key
  end
end
