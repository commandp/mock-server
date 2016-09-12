module ApiRequestHelper

  def request_method_to_bootstrap_class(request_method)
    case request_method
    when 'GET'
      'success'
    when 'POST'
      'primary'
    when 'PUT'
      'info'
    when 'PATCH'
      'info'
    when 'DELETE'
      'danger'
    else
      'default'
    end
  end
end
