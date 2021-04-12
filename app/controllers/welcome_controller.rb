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
        @episodios = 0
        if @serie == "Breaking Bad"
            @serie = "Breaking+Bad"
        else
            @serie = "Better+Call+Saul"
        end
        url = "https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series="+@serie
        response = HTTP.get(url)
        results = JSON.parse(response.to_str)
        if @serie == "Breaking+Bad"
            @serie = "Breaking Bad"
        else
            @serie = "Better Call Saul"
        end
        @lista_episodios = {}
        @numero_episodio = {}
        results.each do |r|
            if r["season"] == @temporada && r["series"] == @serie
                @lista_episodios[r["episode_id"].to_s] = (r["title"])
                @numero_episodio[r["episode_id"].to_s] = (r["episode"])
            end
        end    
        
        
    end

    def detalle_episodio
        @capitulo = params[:capitulo]
        @serie = params[:serie]
        url = "https://tarea-1-breaking-bad.herokuapp.com/api/episodes/"+@capitulo
        response = HTTP.get(url)
        results = JSON.parse(response.to_str)
        @personajes = []
        
        @results = results[0]
        @results["characters"].each do |r|
            @personajes.push(r)
        end
        @largo = @personajes.length().to_s
        
        
        
    end

    def detalle_personaje
        @name = params[:name]
        array = @name.split(" ")
        query = array.join("+")
        url = "https://tarea-1-breaking-bad.herokuapp.com/api/characters?name="+query
        response = HTTP.get(url)
        results = JSON.parse(response.to_str)
        @info = results[0]
        @occup = []
        @aparece_en = []
        @bcs_app = []
        @info["occupation"].each do |i|
            @occup.push(i)  
        end  

        @info["appearance"].each do |i|
            @aparece_en.push(i)  
        end  
        @info["better_call_saul_appearance"].each do |i|
            @bcs_app.push(i)  
        end  
        

    end

    def personajes
        if params[:search].blank?  
            redirect_to("/") and return  
        else  
            @nombre = params[:search].to_s
            query = @nombre
            
            if @nombre.match(/\s/)
                array = @nombre.split(" ")
                query = array.join("+")
            end
            url = "https://tarea-1-breaking-bad.herokuapp.com/api/characters?name="+query
            response = HTTP.get(url)
            results = JSON.parse(response.to_str)
            @results = results
            
        end 
    end

end
