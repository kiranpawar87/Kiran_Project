require 'rails_helper'


RSpec.describe HangmanController, type: :controller do

  render_views
  describe "GET index" do
    subject { get :index }

    it "renders the index template" do
      expect(subject).to render_template(:index)
    end
  end

  describe "POST create" do

    subject { get :create }
    before(:each) do
      @pst=UserInfo.new(:fname=>'abc',:lname=>'xyz',:uname=>'abc@gmail.com',:pass=>'123456')
      if(!@pst.save)
        expect(subject).to redirect_to :controller=>:hangman, :action=>:index
      end
    end
    it "renders the index template from create" do
      expect(subject).to render_template(:index)

    end
  end

  describe "POST game" do
    subject { get :game }
    it "redirect to Error from game" do
      expect(subject).to redirect_to :controller=>:hangman, :action=>:Error
    end
  end

  describe "POST login" do
    subject { get :login }
    it "redirect to Error from game" do
      @row=UserInfo.where(:uname=>'kiranpawar@gmail.com',:pass=>'kiranpawar')
      if(!@row.blank?)
        expect(subject).to redirect_to :controller=>:hangman, :action=>:set
      end
      expect(subject).to render_template(:index)
    end
  end
  describe "GET set" do
    subject{ get :set }
    it "redirect to game from set" do
      expect(subject).to redirect_to :controller=>:hangman, :action=>:game
    end
  end

  describe "GET reset" do
    subject{ get :reset }
    it "render template game from reset" do
       expect(subject).to redirect_to :controller=>:hangman, :action=>:Error
       # expect(subject).to render_template(:game)
    end
  end

  describe "POST wordFormed" do
    render_views
    subject { get :wordFormed }
    it "redirect to Error from game" do

       expect(subject).to redirect_to :controller=>:hangman, :action=>:Error
       # expect(subject).to render_template(:game)
    end
  end
end
