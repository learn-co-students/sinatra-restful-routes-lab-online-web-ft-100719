class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes=Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe=Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe=Recipe.find(params[:id])
    erb :edit
  end

  post '/recipes' do
    @recipe=Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe=Recipe.find(params[:id])
    @recipe.update(params[:recipe])
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe=Recipe.find(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
