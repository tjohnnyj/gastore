require "csv"
require 'json'
require 'net/http'

class LiveHotelsController < ApplicationController
  before_action :set_live_hotel, only: [:show, :edit, :update, :destroy]
    
  # GET /live_hotels
  # GET /live_hotels.json
  def action
    
  end
  
  def initialize
    @live_hotels = []
  end
  
  def index
    CSV.foreach("app/assets/hotels/live_deals.csv","r") do |this_hotel|
        if this_hotel[12] == "voucher"
           primary = []
           uri = URI("http://deals-service.livingsocial.net/api/v1/deals/"+this_hotel[9]+".json?client_name=docs")
           Net::HTTP.get(uri)
           res = Net::HTTP.get_response(uri)
           deal_obj = JSON.parse(res.body)
           deal_obj["options"].each do |opt|
             if opt["primary"] == true
               price = BigDecimal(opt["price"].to_s)
               value = BigDecimal(opt["value"].to_s)
               savings = (100 * price / value).to_i
               savings = savings.to_s + "% savings"
               this_hotel.push(savings)
             end
           end
          elsif this_hotel[12] == "dated_flash"

            uri = URI('http://travel-service.livingsocial.net/travel/browse/deal_for_property?arg%5B1%5D='+this_hotel[1])
            Net::HTTP.get(uri)
            res = Net::HTTP.get_response(uri)
            deal_obj = JSON.parse(res.body)
            puts deal_obj["result"]["44:lead_price"]["9:discount_percentage"]
            savings = deal_obj["result"]["44:lead_price"]["9:discount_percentage"]
            savings = savings.to_s + "% savings"
            this_hotel.push(savings)
         end
         
         puts this_hotel
         @live_hotels << this_hotel
      end
  end

  # GET /live_hotels/1
  # GET /live_hotels/1.json
  def show
  end

  # GET /live_hotels/new
  def new
    @live_hotel = LiveHotel.new
  end

  # GET /live_hotels/1/edit
  def edit
  end

  # POST /live_hotels
  # POST /live_hotels.json
  def create
    @live_hotel = LiveHotel.new(live_hotel_params)

    respond_to do |format|
      if @live_hotel.save
        format.html { redirect_to @live_hotel, notice: 'Live hotel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @live_hotel }
      else
        format.html { render action: 'new' }
        format.json { render json: @live_hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /live_hotels/1
  # PATCH/PUT /live_hotels/1.json
  def update
    respond_to do |format|
      if @live_hotel.update(live_hotel_params)
        format.html { redirect_to @live_hotel, notice: 'Live hotel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @live_hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /live_hotels/1
  # DELETE /live_hotels/1.json
  def destroy
    @live_hotel.destroy
    respond_to do |format|
      format.html { redirect_to live_hotels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_live_hotel
      @live_hotel = LiveHotel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def live_hotel_params
      params[:live_hotel]
    end
end
