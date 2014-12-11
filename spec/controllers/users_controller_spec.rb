require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET #index" do
    
    # let!(:user) { User.create(name: 'Test', email: 'test@example.com', password: 'pw', password_confirmation: 'pw') }
    let!(:user) { FactoryGirl.create(:user) }
    before(:each) { get :index }

    it "returns a list of users" do
      expect(assigns(:users)).to eq([user])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end

  end

  describe "GET #show" do
    let!(:user) { FactoryGirl.create(:user) }
    before(:each) { get :show, id: user }
    it "finds a user" do
      expect(assigns(:user)).to eq(user)
    end
    it "renders the :show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    context "with valid attributes" do

      it "saves a new user" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to :show" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to User.last
      end
    end

    context "with invalid attributes" do
      it "does not save a new user" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user, email: '')
        }.to_not change(User, :count)
      end
      it "renders :new" do
        post :create, user: FactoryGirl.attributes_for(:user, email: '')
        expect(response).to redirect_to new_user_path
      end
    end

  end

  describe "PUT #update" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:old_email) { user.email }
    let!(:new_email) { 'changed@example.org' }
    let(:valid_update_user)   { FactoryGirl.attributes_for(:user, email: new_email) }
    let(:invalid_update_user) { FactoryGirl.attributes_for(:user, email: '') }

    context "with valid attributes" do
      before(:each) do
        put :update, id: user, user: valid_update_user
      end

      it "finds user" do
        expect(assigns(:user)).to eq(user)
      end

      it "updates user attributes" do
        user.reload
        expect(user.email).to eq(new_email)
      end

      it "redirects to show" do
        expect(response).to redirect_to user
      end

    end

    context "with invalid attributes" do
      before(:each) do
        put :update, id: user, user: invalid_update_user
      end

      it "finds user" do
        expect(assigns(:user)).to eq(user)
      end

      it "does not update attributes" do
        user.reload
        expect(user.email).to eq(old_email)
        expect(user.email).not_to eq(new_email)
      end

      it 'renders :edit' do
        expect(response).to render_template :edit
      end

    end
  end

end

