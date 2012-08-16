class CommentsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved

  
	# POST
  def create
    @comment = Comment.build_from(current_risk, session[:user_id], params[:body])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Comment was successfully added.') }
        format.json  { render :json => @comment, :status => :created, :location => current_risk }
      else
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => @comment.errors) }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE
  def destroy
    @comment = Comment.find(params[:id])
    if (@comment.user == current_user) then
      @comment.deleted = true
      @comment.save
      
      respond_to do |format|
          format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Comment was successfully deleted.') }
          format.json  { head :ok }
      end
    else 
      respond_to do |format|
          format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Not authorized.') }
          format.json  { head 403 }
      end      
    end
  end
end
