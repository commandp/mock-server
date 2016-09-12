module ApplicationHelper

  def active_class_for_path(path)
    return 'active' if request.path == '/' && path == 'root'
    if params[:controller] == path && request.path != '/'
      'active'
    end
  end
end
