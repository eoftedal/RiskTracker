class AssetsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved  

  def index
    if (params[:term]) then
      @assets = current_project.assets.where("name LIKE :term", {:term => params[:term] + "%"})
    else
      @assets = current_project.assets.sort_by{|a| a.asset_value.name }
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @assets }
    end
  end

  def show
    @asset = Asset.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @asset }
    end
  end


  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @asset }
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def create
    @asset = Asset.new(params[:asset])
    @asset.project = current_project
    respond_to do |format|
      if @asset.save
        format.html { redirect_to(project_assets_path(current_project), :notice => 'Asset was successfully created.') }
        format.json  { render :json => @asset, :status => :created}
      else
        format.html { render :action => "new" }
        format.json  { render :json => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to(project_assets_path(current_project), :notice => 'Asset was successfully updated.') }
        format.json  { render :json => @asset }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to(project_assets_path(current_project)) }
      format.json  { head :ok }
    end
  end






end
