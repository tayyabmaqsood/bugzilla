Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'welcome#user_main_page', as: :authenticated_root
      resources :projects do
        resources :bugs
      end

      get '/developer/project/:id', to: 'projects#show_developer_project_details', as: 'developer_project_show'
      get '/', to: 'welcome#user_main_page', as: 'root_path'
      get 'index', to: 'welcome#index', as: 'index'
      get '/:id' => 'projects#add_users_to_project', as: 'add_project_users'
      get 'project/:id/add_users', to: 'projects#add_resources', as: 'add_users_to_project'
      get 'project/:id/remove_project_users', to: 'projects#remove_users_from_project', as: 'remove_users_from_project'
      get '/developer/project/:project_id/bug/:bug_id/assign', to: 'bugs#assign_bug_to_developer', as: 'assign_bug_to_developer'
      get '/developer/project/bug/:bug_id/marked', to: 'bugs#mark_resolve', as: 'mark_as_resolve'
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end


  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
