class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/recipes/new' do
    erb :"/recipes/new.html"
  end

  post '/recipes' do
    recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    if recipe.save
      redirect "/recipes/#{recipe.id}"
    else
      redirect "/recipes/error"
    end
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :"/recipes/index.html"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      erb :"/recipes/show.html"
    else
      redirect '/recipes'
    end
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      erb :"/recipes/edit.html"
    else
      redirect '/recipes'
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients])
    if @recipe.save
      erb :"/recipes/show.html"
    else
      redirect '/recipes'
    end
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    erb :"/recipes/delete.html"
  end

  get '/recipes/error' do
    erb :"/recipes/error.html"
  end
end
