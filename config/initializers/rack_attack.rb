Rack::Attack.throttle("episodes by ip", limit: 20, period: 3600) do |request|
	if request.path.include?("/episodes")
		request.ip
	end
end
