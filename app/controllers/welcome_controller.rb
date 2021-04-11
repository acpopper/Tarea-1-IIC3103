require "http"
require 'json'

class WelcomeController < ApplicationController
    
    def series
        @temporadas_bb = 0
        @temporadas_bcs = 0
        response_bb = HTTP.get("https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=Breaking+Bad")
        results_bb = JSON.parse(response_bb.to_str)
        response_bcs = HTTP.get("https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=Better+Call+Saul")
        results_bcs = JSON.parse(response_bcs.to_str)

        results_bb.each do |bb|
            if bb["season"].to_i > @temporadas_bb
                @temporadas_bb = bb["season"].to_i
            end
        end
        

        results_bcs.each do |bcs|
            if bcs["season"].to_i > @temporadas_bcs
                @temporadas_bcs = bcs["season"].to_i
            end
        end
        
        
    end

    def episodios
        @serie = params[:serie]
        @temporada = params[:temporada]
        puts @serie
        puts @temporada
        
    end

    def detalle_episodio
    end

    def detalle_personaje
    end

    def personajes
    end

end
