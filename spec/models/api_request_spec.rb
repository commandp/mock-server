require 'rails_helper'

describe ApiRequest, type: :model do

  describe '#by_method' do
    %w(GET POST PUT PATCH DELETE).each do |attr|
      let!("#{attr.downcase}_request".to_sym) { create(:api_request, request_method: attr) }
    end

    %w(GET POST PUT PATCH DELETE).each do |attr|

      it 'returns correct request' do
        expect(ApiRequest.send("by_#{attr.downcase}")).to eq([send("#{attr.downcase}_request")])
      end

    end
  end

  describe '#by_path' do

    context 'with path params' do

      it 'works with path param' do
        request = create(:api_request, request_path: '/posts/:id')
        expect(ApiRequest.by_path('/posts/3')).to eq(request)
      end

      it 'works with nested resources' do
        request = create(:api_request, request_path: '/posts/:post_id/comments/:id')
        expect(ApiRequest.by_path('/posts/3/comments/5')).to eq(request)
      end

    end

    context 'with strict path' do

      it 'works with strict path' do
        static_path = create(:api_request, request_path: '/foo/bar')
        expect(ApiRequest.by_path('/foo/bar')).to eq(static_path)
      end

    end

    it 'returns nil when no match' do
      request = create(:api_request, request_path: '/foo/bar')
      expect(ApiRequest.by_path('/posts/3')).to be_nil
    end

  end

  describe 'save' do

    it 'removes request_path end slach' do
      request = build(:api_request, request_path: '/123/')
      request.save
      expect(request.request_path).to eq('/123')
    end
  end
end
