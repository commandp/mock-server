require 'rails_helper'

describe CollectionsController, type: :controller do


  describe 'new' do
    let(:project) { create(:project) }

    it 'success' do
      get :new, params: { project_id: project.id }
      expect(response).to be_success
      expect(response).to render_template('new')
    end

  end

  describe 'create' do
    let(:project) { create(:project) }

    it 'success' do
      expect { post :create, params: { project_id: project.id, collection: attributes_for(:collection) } }.to change(Collection, :count).by(1)
    end

    it 'fails validation' do
      expect { post :create, params: { project_id: project.id, collection: {name: ''} } }.not_to change(Collection, :count)
    end

  end

  describe 'edit' do

    let!(:collection) { create(:collection) }

    it 'success' do
      get :edit, params: { project_id: collection.project.id, id: collection.id }
      expect(response).to be_success
      expect(response).to render_template('edit')
    end
  end

  describe 'update' do
    let!(:collection) { create(:collection) }

    it 'success' do
      put :update, params: { project_id: collection.project.id, id: collection.id, collection: { name: 'Collection!' } }
      expect(Collection.last.name).to eq('Collection!')
      expect(response).to redirect_to project_path(collection.project)
    end
  end

  describe 'destroy' do
    let!(:collection) { create(:collection) }
    subject { delete :destroy, params: { project_id: collection.project.id, id: collection.id } }

    it 'success' do
      project = collection.project
      expect(subject).to redirect_to project_path(project)
      expect(Collection.count).to eq(0)
    end
  end

end
