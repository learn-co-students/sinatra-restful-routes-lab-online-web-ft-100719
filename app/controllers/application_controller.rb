class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    #Recipe.new
    erb :index
  end

  get '/recipes/new' do 
    erb :new
  end

  post '/recipes' do 
    @recipes = Recipe.new(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    if @recipes.save
      redirect "/recipes/#{@recipes.id}"
    else 
      redirect "/recipes/new"
    end
  end

  get '/recipes/:id' do 
    @recipes = Recipe.find_by_id(params[:id])
    #binding.pry
    if @recipes 
      erb :show 
    else
      redirect "/recipes"
    end
  end 
  
  get '/recipes/:id/edit' do 
    @recipes = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit action
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.name = params[:name]
    @recipes.ingredients = params[:ingreditents]
    @recipes.cook_time = params[:cook_time]
    @recipes.save
    redirect "/recipes/#{@recipes.id}"
  end

  delete '/recipes/:id' do #delete action
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.destroy
    redirect '/recipes'
  end

end
