class UrlsController < ApplicationController
  before_action :find_url, only: :show
  skip_before_action :verify_authenticity_token

  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.sanitize
    if @url.new_url?
      if @url.save
        @short_url = get_url
        render 'new'
      else
        flash[:notice] = @url.errors.full_messages
        redirect_to '/'
      end
    else
      flash[:notice] = "Already exists"
      redirect_to '/'
    end
  end

  def show
    redirect_to @url.sanitize_url
  end

  def stats
    @ip_add = request.ip
    @location = request.location.country
  end

  private

  def get_url
    host = request.host_with_port
    @long_url = @url.sanitize_url
    host + '/' + @url.short_url
  end

  def find_url
    @url = Url.find_by(short_url: params[:short_url])
  end

  def url_params
    params.permit(:long_url)
  end
end