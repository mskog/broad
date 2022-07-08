# typed: strict
Rack::Attack.throttle("episodes index", limit: 10, period: 3600) do |request|
	if request.path.include?("/episodes") && !request.path.include?("/download")
		request.path
	end
end

Rack::Attack.throttle("episodes download", limit: 2, period: 3600) do |request|
	if request.path.include?("/episodes") && request.path.include?("download")
		request.path
	end
end
