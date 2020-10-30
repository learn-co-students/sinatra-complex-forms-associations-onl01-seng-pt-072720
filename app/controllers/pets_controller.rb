class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    # binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    # binding.pry
    @owner = @pet.owner
    @owner.save
    # binding.pry
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    # binding.pry
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    redirect to "/pets/#{@pet.id}"
  end
end