require 'rails_helper'

describe ProjectsController, type: :controller do

  let(:project) { create(:project) }

  describe 'index' do

    it 'success' do
      get :index
      expect(response).to be_success
    end

  end

  describe 'new' do

    it 'success' do
      get :new
      expect(response).to be_success
    end

  end

  describe 'edit' do

    it 'success' do
      get :edit, params: { id: project.slug }
      expect(response).to be_success
    end

  end

  describe 'create' do

    it 'success' do
      params = attributes_for(:project)
      post :create, params: { project: params }
      expect(response).to redirect_to project_path(params[:name].downcase)
    end

  end

  describe 'update' do

    it 'success' do
      put :update, params: { id: project.name.downcase, project: attributes_for(:project) }
      expect(response).to redirect_to project_path(project.name.downcase)
    end

    it 'fails without empty name' do
      put :update, params: { id: project.name.downcase, project: { name: '' } }
      expect(response).to be_success
      expect(project.name).not_to eq('')
    end
  end

end
