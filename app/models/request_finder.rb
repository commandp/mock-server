# TODO: 需要缓存或者其他方式
class RequestFinder
  def self.find(path, method)
    new(path, method).find
  end

  def initialize(path, method)
    @path = path
    @method = method.upcase
  end

  def find
    request_ids = simulate.simulate(@path).try(:memos)
    ApiRequest.where(id: request_ids, request_method: @method).first
  end

  private

  def simulate
    @simulate ||= begin
      parser = ::ActionDispatch::Journey::Parser.new
      ast = ApiRequest.all.pluck(:id, :request_path).map { |id, request_path|
        ast = parser.parse request_path
        ast.each { |n| n.memo = id }
        ast
      }

      builder = ::ActionDispatch::Journey::GTG::Builder.new ActionDispatch::Journey::Nodes::Or.new ast
      table = builder.transition_table
      ActionDispatch::Journey::GTG::Simulator.new table
    end
  end
end