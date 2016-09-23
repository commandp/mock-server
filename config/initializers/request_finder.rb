class RequestFinder
  include Singleton

  def find(path, method)
    request_ids = simulate.simulate(path).try(:memos)
    return nil if request_ids.blank?

    ApiRequest.where(id: request_ids, request_method: method.upcase).first
  end

  def reload
    @simulate = nil
  end

  private

  def simulate
    @simulate ||= begin
      parser = ::ActionDispatch::Journey::Parser.new
      ast = ApiRequest.includes(:project).all.map do |api_request|
        ast = parser.parse api_request_full_path(api_request)
        ast.each { |n| n.memo = api_request.id }
        ast
      end

      builder = ::ActionDispatch::Journey::GTG::Builder.new ActionDispatch::Journey::Nodes::Or.new ast
      table = builder.transition_table
      ActionDispatch::Journey::GTG::Simulator.new table
    end
  end

  def api_request_full_path(api_request)
    "/#{api_request.project.slug}#{api_request.request_path}"
  end
end
