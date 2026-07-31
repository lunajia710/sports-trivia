RubyLLM.configure do |config|
  config.gemini_api_key = ENV["GEMINI_API_KEY"]
  config.gemini_api_base = "gemini-flash-latest"
end
