class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get "/recipes/new" do
    
    erb :new
  
  end
  
  post "/recipes" do
    
    new_recipe = Recipe.create(params)
    redirect "/recipes/#{new_recipe.id}"
  end
  
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end
  
  delete "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect "/recipes"
  end
  
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end
  
  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end
  
  patch "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.update(params)
    redirect "/recipes/#{@recipe.id}"
  end
  
  








  # code actions here!

end
