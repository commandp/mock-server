class RequestRoutes
  include Singleton

  def match(path, method)
    memos = simulate.simulate(path).try(:memos)
    return nil if memos.blank?
    memos.reverse.find { |memo| memo[:request_method] == method }
  end

  def from_string
    ActionDispatch::Journey::Path::Pattern.from_string('/articles/:id/edit(.:format)')
  end

  def add_route(api_request)
    append_to_ast(api_request)
    clear_cache
  end

  def clear_cache
    @simulate = nil
  end

  def reload
    @ast = nil
    @simulate = nil
  end

  private

  def simulate
    @simulate ||= begin
      builder = ActionDispatch::Journey::GTG::Builder.new ActionDispatch::Journey::Nodes::Or.new ast
      table = builder.transition_table
      ActionDispatch::Journey::GTG::Simulator.new table
    end
  end

  def ast
    @ast ||= begin
      ApiRequest.all.map do |api_request|
        parse_to_nodes(api_request)
      end
    end
  end

  def parse_to_nodes(api_request)
    memo = {
      request_id: api_request.id,
      request_method: api_request.request_method,
      pattern: ActionDispatch::Journey::Path::Pattern.from_string(api_request.request_path)
    }
    nodes = parser.parse api_request_full_path(api_request)
    nodes.each { |n| n.memo = memo }
    nodes
  end

  def append_to_ast(api_request)
    @ast = ast || []
    @ast << parse_to_nodes(api_request)
  end

  def api_request_full_path(api_request)
    "/#{api_request.project.slug}#{api_request.request_path}"
  end

  def parser
    ActionDispatch::Journey::Parser.new
  end
end
