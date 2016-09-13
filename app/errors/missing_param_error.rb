class MissingParamError < ApplicationError

  def message
    "Param is missing or the value is empty: #{caused_by}"
  end

  def status
    :bad_request
  end

end
