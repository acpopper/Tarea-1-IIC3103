require "http"
require 'json'

class WelcomeController < ApplicationController
    
    def series
        response = HTTP.get("https://tarea-1-breaking-bad.herokuapp.com/api/characters")
        results = JSON.parse(response.to_str)
        name = results[0]['name']
        @name = name;
    end

    def episodios
    end

    def detalle_episodio
    end

    def detalle_personaje
    end

    def personajes
    end

end
