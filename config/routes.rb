# == Route Map
#
#                        Prefix Verb   URI Pattern                                       Controller#Action
#                          root GET    /                                                 properties#index
#     users_dissociate_property PATCH  /users/dissociate_property(.:format)              users/registrations#dissociate_property
#              new_user_session GET    /users/sign_in(.:format)                          devise/sessions#new
#                  user_session POST   /users/sign_in(.:format)                          devise/sessions#create
#          destroy_user_session DELETE /users/sign_out(.:format)                         devise/sessions#destroy
#             new_user_password GET    /users/password/new(.:format)                     devise/passwords#new
#            edit_user_password GET    /users/password/edit(.:format)                    devise/passwords#edit
#                 user_password PATCH  /users/password(.:format)                         devise/passwords#update
#                               PUT    /users/password(.:format)                         devise/passwords#update
#                               POST   /users/password(.:format)                         devise/passwords#create
#      cancel_user_registration GET    /users/cancel(.:format)                           users/registrations#cancel
#         new_user_registration GET    /users/sign_up(.:format)                          users/registrations#new
#        edit_user_registration GET    /users/edit(.:format)                             users/registrations#edit
#             user_registration PATCH  /users(.:format)                                  users/registrations#update
#                               PUT    /users(.:format)                                  users/registrations#update
#                               DELETE /users(.:format)                                  users/registrations#destroy
#                               POST   /users(.:format)                                  users/registrations#create
#         new_user_confirmation GET    /users/confirmation/new(.:format)                 devise/confirmations#new
#             user_confirmation GET    /users/confirmation(.:format)                     devise/confirmations#show
#                               POST   /users/confirmation(.:format)                     devise/confirmations#create
#               new_user_unlock GET    /users/unlock/new(.:format)                       devise/unlocks#new
#                   user_unlock GET    /users/unlock(.:format)                           devise/unlocks#show
#                               POST   /users/unlock(.:format)                           devise/unlocks#create
# current_user_joins_properties PATCH  /properties/current_user_joins(.:format)          properties#current_user_joins
#           property_room_types GET    /properties/:property_id/room_types(.:format)     room_types#index
#                               POST   /properties/:property_id/room_types(.:format)     room_types#create
#        new_property_room_type GET    /properties/:property_id/room_types/new(.:format) room_types#new
#                edit_room_type GET    /room_types/:id/edit(.:format)                    room_types#edit
#                     room_type GET    /room_types/:id(.:format)                         room_types#show
#                               PATCH  /room_types/:id(.:format)                         room_types#update
#                               PUT    /room_types/:id(.:format)                         room_types#update
#                               DELETE /room_types/:id(.:format)                         room_types#destroy
#                    properties GET    /properties(.:format)                             properties#index
#                               POST   /properties(.:format)                             properties#create
#                  new_property GET    /properties/new(.:format)                         properties#new
#                 edit_property GET    /properties/:id/edit(.:format)                    properties#edit
#                      property GET    /properties/:id(.:format)                         properties#show
#                               PATCH  /properties/:id(.:format)                         properties#update
#                               PUT    /properties/:id(.:format)                         properties#update
#                               DELETE /properties/:id(.:format)                         properties#destroy
#

Rails.application.routes.draw do
	# Guide: 
	# http://www.theodinproject.com/courses/ruby-on-rails/lessons/routing
	
	# Best Practices:
	# https://github.com/bbatsov/rails-style-guide

	root 'properties#index'

	devise_scope :user do
		# get "/some/route" => "some_devise_controller"
		# get "signup", to: "devise/registrations#new"
		patch "users/dissociate_property", to: "users/registrations#dissociate_property"
		# patch "users/associate_property/:id"
		# get "users/help", to: "users/registrations#help"
	end
	devise_for :users, :controllers => { 
		registrations: "users/registrations"
	}

	resources :properties do
		# PATCH does a partial update and PUT is used to update the whole resource
		patch 'current_user_joins', on: :collection
		resources :room_types, shallow: true
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
