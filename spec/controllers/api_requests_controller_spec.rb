require 'rails_helper'

describe ApiRequestsController, type: :controller do

  let(:api_request) { create(:api_request) }

  describe 'new' do

    it 'success' do
      get :new, params: { project_id: api_request.project.id }
      expect(response).to be_success
      expect(response).to render_template('new')
    end

  end

  describe 'show' do

    it 'success' do
      get :show, params: { project_id: api_request.project.id, id: api_request.id }
      expect(response).to be_success
      expect(response).to render_template('show')
    end

  end

  describe 'create' do
    let(:project) { create(:project) }

    it 'success' do
      expect { post :create, params: { project_id: project.id, api_request: attributes_for(:api_request) } }.to change(ApiRequest, :count).by(1)
    end

    it 'fails validation' do
      expect { post :create, params: { project_id: project.id, api_request: {request_method: ''} } }.not_to change(ApiRequest, :count)
    end

  end

  describe 'edit' do
    
    let!(:api_request) { create(:api_request) }

    it 'success' do
      get :edit, params: { project_id: api_request.project.id, id: api_request.id }
      expect(response).to be_success
      expect(response).to render_template('edit')
    end
  end

  describe 'update' do
    let!(:api_request) { create(:api_request) }

    it 'success' do
      put :update, params: { project_id: api_request.project.id, id: api_request.id, api_request: { request_method: 'PUT' } }
      expect(ApiRequest.last.request_method).to eq('PUT')
      expect(response).to redirect_to(project_api_request_url(api_request.project, api_request))
    end
  end

  describe 'destroy' do
    let!(:api_request) { create(:api_request) }
    subject { delete :destroy, params: { project_id: api_request.project.id, id: api_request.id } }

    it 'success' do
      project = api_request.project
      expect(subject).to redirect_to project_path(project)
      expect(ApiRequest.count).to eq(0)
    end
  end

end
