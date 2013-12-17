module ApplicationHelper
	def avatar_url(user, size)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=" + size.to_s + "&d=mm"
	end
end
