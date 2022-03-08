class StaticPagesController < ApplicationController
  include Pagy::Backend

  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = pagy current_user.feed,
                       items: Settings.settings.per_page_10
  end

  def help; end

  def about; end

  def contact; end
end
