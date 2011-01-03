class PersonsController < ApplicationController
  def index()
    graph = Koala::Facebook::GraphAPI.new(current_user.authentications.first.token)
    @friends = graph.get_connections("me","friends")
    @nfriends = Array.new()
    @friends.each {|f|
      ct=User.where(:follow_uid => f['id']).count
      f['count']=ct
      @nfriends.push(f)
    }
    followers = User.where(:follow_uid => current_user.authentications.first.uid)
    @followers = Array.new()
    followers.each {|f|
      gl=graph.get_object(f.authentications.first.uid)
      f['name']=gl['name']
      @followers.push(f)
    }
  end
  def follow()
    graph = Koala::Facebook::GraphAPI.new(current_user.authentications.first.token)
    uid=params[:uid]
    @obj=graph.get_object(uid)
    current_user.follow_uid=uid
    current_user.follow_name=@obj['name']
    current_user.save()
    #flash[:message]="You are now following #{obj['name']}"
    #redirect_to :action => :index
  end
  def follow_post()
    graph = Koala::Facebook::GraphAPI.new(current_user.authentications.first.token)
    uid=params[:uid]
    graph.put_object(uid,"feed",:message => params[:post])
    flash[:message]="Posted to your leader's wall"
    redirect_to :action => :index
  end
end
