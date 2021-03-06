class SlackController < ApplicationController
    require 'active_support'
    require 'uri'
    def index
    end

    def create
        @body = JSON.parse(request.body.read)
        case @body['type']
        when 'url_verification'
            render json: @body
        when 'event_callback'
            # ..
        end
        json_hash  = params[:slack]
        Body::TestService.new(json_hash).execute
    end

    def action
        body_before=URI.decode(request.body.read)
        gonna_parse=body_before.gsub(/payload=/,"")
        body = JSON.parse(gonna_parse)
        p body["trigger_id"]
        
        # extend ActiveSupport::JSON.decode(body)
        # how_about = JSON.decode(body)
        # p how_about
        #p "hello"
        #deleted = request.body.read.delete("'")
        #p deleted
        #@params ||= JSON.parse(deleted, {:symbolize_names => true})
        #p @params
        #p unencoded
        #body =JSON.parse(request.body.read)
        #body = JSON.stringify(request.body.read)
        Body::Action.new(body).interact
    end
end
