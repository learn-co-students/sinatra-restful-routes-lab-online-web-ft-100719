class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :'/recipes/index'
  end

  post '/recipes' do
    @recipe = Recipe.new(params)
    if @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    end
  end

  get '/recipes/new' do
    erb :'/recipes/new'
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    if @recipe
      erb :'/recipes/show'
    end
  end

  get '/recipes/:id/edit' do
      @recipe = Recipe.find(params[:id])
      erb :'/recipes/edit'
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    if @recipe
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.cook_time = params[:cook_time]
      @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    end
  end

  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.delete
    redirect to "/recipes"
  end
end
