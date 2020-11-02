class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    @owners = Owner.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params[:pet_name])
    if params.has_key?(:pet)
      @owner = Owner.find_by_id(params[:pet][:owner_id])
      @owner.pets << @pet
    else
      @owner = Owner.create(name: params[:owner_name])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if params[:owner][:name].blank?
      @owner = Owner.find(params[:pet][:owner_ids][0].to_i)
      @pet.update(name: params[:pet_name], owner_id: @owner.id)
    else
      @owner = Owner.create(name: params[:owner][:name]) unless params[:owner][:name].blank?
      @pet.update(name: params[:pet_name], owner_id: @owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end
end