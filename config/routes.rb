# == Route Map
#
#                   Prefix Verb   URI Pattern                       Controller#Action
#         new_user_session GET    /users/sign_in(.:format)          devise/sessions#new
#             user_session POST   /users/sign_in(.:format)          devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)         devise/sessions#destroy
#        new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#            user_password PATCH  /users/password(.:format)         devise/passwords#update
#                          PUT    /users/password(.:format)         devise/passwords#update
#                          POST   /users/password(.:format)         devise/passwords#create
# cancel_user_registration GET    /users/cancel(.:format)           devise/registrations#cancel
#    new_user_registration GET    /users/sign_up(.:format)          devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)             devise/registrations#edit
#        user_registration PATCH  /users(.:format)                  devise/registrations#update
#                          PUT    /users(.:format)                  devise/registrations#update
#                          DELETE /users(.:format)                  devise/registrations#destroy
#                          POST   /users(.:format)                  devise/registrations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format) devise/confirmations#new
#        user_confirmation GET    /users/confirmation(.:format)     devise/confirmations#show
#                          POST   /users/confirmation(.:format)     devise/confirmations#create
#          new_user_unlock GET    /users/unlock/new(.:format)       devise/unlocks#new
#              user_unlock GET    /users/unlock(.:format)           devise/unlocks#show
#                          POST   /users/unlock(.:format)           devise/unlocks#create
#                     root GET    /                                 properties#index
#               properties GET    /properties(.:format)             properties#index
#                          POST   /properties(.:format)             properties#create
#             new_property GET    /properties/new(.:format)         properties#new
#            edit_property GET    /properties/:id/edit(.:format)    properties#edit
#                 property GET    /properties/:id(.:format)         properties#show
#                          PATCH  /properties/:id(.:format)         properties#update
#                          PUT    /properties/:id(.:format)         properties#update
#                          DELETE /properties/:id(.:format)         properties#destroy
#

Rails.application.routes.draw do
	# Guide: 
	# http://www.theodinproject.com/courses/ruby-on-rails/lessons/routing
	
	# Best Practices:
	# https://github.com/bbatsov/rails-style-guide

	root 'properties#index'
	devise_for :users, :controllers => { 
		registrations: "users/registrations"
	}

	resources :properties do
		# PATCH does a partial update and PUT is used to update the whole resource
		patch 'current_user_joins', on: :collection
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
