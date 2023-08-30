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

  resources :organization_surveys, path: 'organization_survey', controller: 'organization/organization_surveys' do
    get 'submissions', to: 'organization_survey/submissions#index'
    # get 'submissions/flat', to: 'organization_survey/submissions#flat'
    get 'results', to: 'organization_survey/results#index'
  end

  resources :organizations, path: 'organization' do
    get 'organization_surveys', to: 'organization/organization_surveys#index'
  end

  resources :submissions, path: 'submission', controller: 'organization_survey/submissions', except: [:index] do
    get 'responses', to: 'submission/responses#index'
  end
  resources :responses, path: 'response', controller: 'submission/responses', except: [:index]

  resources :surveys, path: 'survey' do
    resources :groups, controller: 'survey/groups', only: [:index]
  end

  get 'survey/start/:access_code', to: 'surveys#start'

  resources :groups, path: 'group', controller: 'survey/groups', except: [:index] do
    get 'questions', to: 'survey/group/questions#index'
  end

  get 'respondent/current', to: 'survey/respondents#current'
  resources :respondents, path: 'respondent', controller: 'survey/respondents', only: [:show, :create]

  resources :questions, controller: 'survey/group/questions', path: 'question', except: [:index] do
    get 'answers', to: 'survey/group/question/answers#index'
    get 'likert_setting', to: 'survey/group/question/likert_settings#index'
  end
  resources :answers, controller: 'survey/group/question/answers', path: 'answer', except: [:index]
  resources :likert_settings, controller: 'survey/group/question/likert_settings', path: 'likert_setting', except: [:index]

  # Catch all for vue router
  get '*path', to: 'home#index', constraints: -> (request) do
    !request.xhr? && request.format.html?
  end
end
