Dir["#{Rails.root}/app/api/*.rb"].each {|file| require file}

module API
	class API < Grape::API

    helpers do 
      def authenticated?
        return false if params[:token].nil?
        User.exists?(api_key: params[:token])
      end
    end

    mount V1::API
    mount V2::API
	end
end