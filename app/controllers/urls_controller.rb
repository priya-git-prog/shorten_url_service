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
    if @url.expires_at >= Date.today
      @url.update_attribute(:clicks, @url.clicks + 1)
      redirect_to @url.sanitize_url
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def stats
    @ip_add = request.ip
    #doesn't works on local envt.
    @location = request.location.country #or  Geocoder.search(request.ip)[0].data["country"]
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