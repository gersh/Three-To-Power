class MessagesController < ApplicationController
  def index()
    @other = Message.joins(:message_permissions).where(:message_permissions => { :uid => current_user.authentications.first.uid })
    @my = Message.where(:user_id => current_user.id)
  end
  def create()
    message=Message.new(:user_id => current_user.id, :text => params[:msg])
    message.save()
    redirect_to '/messages'
  end
  def leader()
    id=params[:id]
    message=Message.find(id)
    if message.user_id==current_user.id || message.message_permissions.where(:uid => current_user.authentications.first.uid)
        if current_user.follow_uid
          mp=MessagePermission.new(:uid=>current_user.follow_uid, :message_id => id)
          mp.save()
        end
    end
    flash[:message]="Message sent to leader"
    redirect_to '/messages'
  end
  def follower()
    id=params[:id]
    message=Message.find(id)
    if message.user_id==current_user.id || message.message_permissions.where(:uid => current_user.authentications.first.uid)
      current_user.followers.each {|e|
        uid=e.authentications.first.uid
        mp=MessagePermission.new(:uid=>uid, :message_id => id)
        mp.save()
      }
    end
    flash[:message]="Message sent to followers"
    redirect_to '/messages'
  end
end
