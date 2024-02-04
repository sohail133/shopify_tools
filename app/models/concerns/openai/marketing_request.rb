class Openai::MarketingRequest
  SELECTED_MODEL = "text-davinci-003"
  TEMPERATURE = 0.8
  MAX_TOKENS = 100
  BEST_OF = 1
  FREQUENCY_PENALTY = 0.7
  PRESENCE_PENALTY = 1

  attr_reader :name, :description, :post, :keywords, :tone_of_voice, :shop_id, :request_type

  def call(name, description, post, keywords, tone_of_voice, shop_id, request_type)
    @name = name
    @description = description
    @post = post
    @keywords = keywords
    @tone_of_voice = tone_of_voice
    @shop_id = shop_id
    @request_type = request_type

    generate_response(Openai::MarketingPrompts.new.call(name:, description:, post:, keywords:, tone_of_voice:, request_type:))
  end

  private

  def generate_response(prompt)
    response = OpenAI::Client.new.completions(
      parameters: {
        model: SELECTED_MODEL,
        prompt: prompt,
        max_tokens: MAX_TOKENS,
        temperature: TEMPERATURE,
        frequency_penalty: FREQUENCY_PENALTY,
        presence_penalty: PRESENCE_PENALTY,
        best_of: BEST_OF
      })

    if response['error'].present?
      raise "OpenAI error: #{response['error']['type']} - #{response['error']['message']}"
    else
      save_response(response:, prompt:)
      response.dig('choices', 0, 'text')
    end
  end

  def save_response(response:, prompt:)
    Openai::Generation.create(
      shop_id: shop_id,
      request_id: response.dig('id'),
      model: response.dig('model'),
      request_type: request_type,
      prompt: prompt,
      content: response.dig('choices', 0, 'text'),
      prompt_cost: response.dig('usage', 'prompt_tokens'),
      completion_cost: response.dig('usage', 'completion_tokens'),
      word_count: response.dig('choices', 0, 'text').split(' ').count
    )
  end
end
