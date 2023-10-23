require 'gossip'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  get '/gossips/new/' do
    erb :new_gossips
  end
  post '/gossips/new/' do
    
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    
    # Rediriger vers la page d'accueil ou effectuer toute autre action souhaitée
    redirect '/'

  end  

  get '/gossip/:id' do
    # Récupérez le gossip spécifique par ID
    gossip = Gossip.find(params[:id])
    
    # Vérifiez si le gossip existe
    if !gossip[0]
      redirect '/'
     
      # Gére le cas où le gossip avec l'ID donné n'existe pas
    else
      # Renvoi les informations du gossip en utilisant un modèle ERB
      
      erb :show , locals: { gossip: Gossip.find(params['id']) }

    end
  end  

  #Page de modification de gossip
  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.all[params[:id].to_i], id: params[:id].to_i}
  end
  #traitement des données du formulaire de modification de gossip
  post '/gossips/:id/edit' do
    Gossip.update(params["gossip_author"], params["gossip_content"],params[:id].to_i)
    redirect '/'
  end
  
end
