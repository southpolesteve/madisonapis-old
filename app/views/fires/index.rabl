collection @fires
attributes :id, :title, :type, :alarm, :arrival, :controlled, :location, :href
node(:next_page){ "http://www.madisonapis.com/fires?page=#{params[:page] ? params[:page]+1 : 2}"}


