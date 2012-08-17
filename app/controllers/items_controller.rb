require 'csv'

class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @receipt = @item.receipt

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
        format.js { render layout: false, content_type: 'text/html' }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @receipt = @item.receipt
    @item.destroy

    respond_to do |format|
      format.html { redirect_to @receipt }
      format.json { head :no_content }
    end
  end

  def import
    if request.post?
      tmp = params[:file_upload][:my_file].tempfile

      @receipt = nil
      date = nil
      store = nil

      CSV.foreach(tmp.path, :headers => true) do |row|
        attrs = row.to_hash

        next if attrs['store'] == 'Total'

        # Rails.logger.debug "attrs: #{attrs}"

        if attrs['store']
          store = attrs['store']
          Rails.logger.debug "store: #{store}"
        end

        if attrs['date']
          date = Date.strptime(attrs['date'], '%m/%d/%y')
          Rails.logger.debug "create receipt: #{store} #{date}"
          @receipt = Receipt.create! :store => store, :date => date
        end

        attrs.delete 'store'
        attrs.delete 'date'

        count = attrs.delete('count').to_i
        count = 1 if count < 1

        count.times do
          Rails.logger.debug "adding item: #{attrs.inspect}"
          @receipt.items << Item.new(attrs)
        end
      end

      redirect_to :receipts
    end
  end

end
