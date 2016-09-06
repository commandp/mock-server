module FontawesomeHelper

  def fa_icon(icon)
    content_tag(:i, '', class: "fa fa-#{icon}")
  end
end
