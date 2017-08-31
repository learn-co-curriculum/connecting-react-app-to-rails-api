class API::CampaignsController < ApplicationController
    before_action :set_campaign, only: [:show, :update, :destroy] 

    # GET /api/campaigns 
    def index 
        @campaigns = Campaign.all 
        render json: @campaigns, status: 200 
    end

    # GET /api/campaigns/:id
    def show 
        render json: @campaign, status: 200
    end

    # POST /api/campaigns
    def create 
        @campaign = Campaign.create!(campaign_params) 
        render json: @campaign, status: 201
    end

    # PUT /api/campaigns/:id
    def update 
        @campaign.update(campaign_params) 
        render json: @campaign, status: 200
    end

    # DELETE /api/campaigns/:id
    def destroy 
        @campaign.destroy
        head :no_content 
    end

    private 

        def campaign_params
            params.require(:campaign).permit(:title, :description, :goal, :pledged) 
        end

        def set_campaign  
            @campaign = Campaign.find(params[:id]) 
        end
end
