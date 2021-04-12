Rails.application.routes.draw do
  root 'welcome#series'

  get 'episodios', to: 'welcome#episodios'
  get 'detalle', to: 'welcome#detalle_episodio'
  get 'personaje', to: 'welcome#detalle_personaje'
  get 'personajes', to: 'welcome#personajes'

end

