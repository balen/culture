Rails.application.routes.draw do
  filter :locale

  devise_for :users, path: 'auth',
            controllers: {
              sessions: 'users/sessions',
              passwords: 'users/passwords',
              registrations: 'users/registrations',
              unlocks: 'users/unlocks'
            }, defaults: { format: :json }

  # 
  get "home/index"  
  root to: "home#index"

  resources :users, path: 'user'
  get 'user/session/me', to: 'users#me'

  resources :organizations, path: 'organization' do
    get 'organization_surveys', to: 'organization/organization_surveys#index'
  end

  resources :organization_surveys, path: 'organization_survey', controller: 'organization/organization_surveys', except: [:index] do
    get 'submissions', to: 'organization_survey/submissions#index'
    # get 'submissions/flat', to: 'organization_survey/submissions#flat'
  end

  resources :surveys, path: 'survey'

  resources :submissions, path: 'submission', controller: 'organization_survey/submissions', except: [:index] do
    get 'responses', to: 'submission/responses#index'
  end
  resources :responses, path: 'response', controller: 'submission/responses', except: [:index]

  # Catch all for vue router
  get '*path', to: 'home#index', constraints: -> (request) do
    !request.xhr? && request.format.html?
  end
end
