require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  let!(:user) { FactoryGirl.create(:user) }

  describe "GET new" do
    it "returns a login form" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    
    context "with valid login credentials" do
      before(:each) { post :create, session: { email: user.email, password: user.password } } 
      it "sets the session user id" do
        expect(session[:user_id]).to eq(user.id) 
      end
      it "redirects to the user profile" do
        expect(response).to redirect_to user
      end
    end

    context "with invalid login credentials" do
      before(:each) { post :create, session: { email: user.email, password: 'nope' } }
      it "does not set the session user id" do
        expect(session[:user_id]).not_to eq(user.id)
      end
      it "renders the login form" do
        expect(response).to render_template :new
      end
      it "alerts that email/password is invalid" do
        expect(flash[:alert]).to eq('Invalid email/password combo')
      end
    end

  end

  describe "GET destroy" do
    before(:each) do
      post :create, session: { email: user.email, password: user.password }
      expect(session[:user_id]).to eq(user.id)
      delete :destroy
    end
    it "unsets user_id in session" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to login" do
      expect(response).to redirect_to login_path
    end
  end

end
