require 'rails_helper'

# Reference:
# https://relishapp.com/rspec/rspec-rails/docs/controller-specs
# https://medium.com/just-tech/rspec-controller-or-request-specs-d93ef563ef11
# https://stackoverflow.com/questions/60160204/rails-controller-test-with-rspec
# https://stackoverflow.com/questions/38533929/run-rspec-controller-test-on-put-method-correctly
# https://stackoverflow.com/questions/10054215/rails-3-correct-test-for-put-method-via-rspec
# https://stackoverflow.com/questions/6296235/undefined-method-get-for-rspeccoreexamplegroupnested-10x00000106db51f

RSpec.describe MoviesController do
  describe "GET new" do
    it 'create new movie' do
      Movie.new
      get :new
      expect(response).to be_successful
      expect(response).to render_template('new')
    end
  end

  describe "GET index" do
    it 'show all movie' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end
  describe "POST update" do
    it 'show the new director' do
      new_movie = Movie.create!(title: 'Jian Gao', rating: 'G')
      put :update, id: new_movie.id, movie: {director: 'Jacky'}
      new_movie.reload
      expect(new_movie.director).to eql 'Jacky'
    end
  end
  describe "delete" do
    it 'should delete a record' do
      new_movie = Movie.create!(title: 'Jian Gao', rating: 'G')
      delete :destroy, id: new_movie.id
      expect(Movie.find_by(title: new_movie.title)).to be nil
    end
  end

  describe "create" do
    it 'should create a record' do
      before = Movie.find_by(title: 'Hahaha')
      new_movie = Movie.create!(title: 'Hahaha', rating: 'G')
      after = Movie.find_by(title: 'Hahaha')
      expect(before).to be nil
      expect(after).should_not be_nil
    end
  end

  describe "edit" do
    it 'should redirect to the edit page' do
      new_movie = Movie.create!(title: 'Hahaha', rating: 'G')
      get :edit, id: new_movie.id
      expect(response).to be_successful
      expect(response).to render_template('edit')
    end
  end
  

  describe "find_same_director" do
    before(:each) do
      new_movie1 = Movie.create!(title: 'Jian', rating: 'G', director: 'LOL')
      new_movie2 = Movie.create!(title: 'Jacky', rating: 'G', director: 'LOL')
      new_movie3 = Movie.create!(title: 'Gao', rating: 'G')
    end

    it 'should get movies of the same director' do
      result = Movie.share_director('Jian')
      get :find_same_director, {title: 'Jian' }
      # Movie.all.each do |movie|
      #   puts movie.title
      #   puts movie.director
      # end
      result_titles = []
      result.each do |movie|
        result_titles.push(movie.title)
      end
    
      expect(result_titles).to include "Jacky"
    end
    it 'should go back to home page if no director' do
      get :find_same_director, {title: 'Gao'}
      expect(response).to redirect_to root_url
    end
  end


end
