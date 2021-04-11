Rails.application.routes.draw do
  root 'welcome#series'

  get 'episodios', to: 'welcome#episodios'
end

