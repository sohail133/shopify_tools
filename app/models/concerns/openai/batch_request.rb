class Openai::BatchRequest
  MAX_TOKENS = 2048
  TOP_P = 0.5
  FREQUENCY_PENALTY = 0.7
  PRESENCE_PENALTY = 1
  BEST_OF = 1
  SELECTED_MODEL = "text-davinci-003"
  TEMPERATURE = 1

  attr_reader :product

  def initialize(product, title, description, keywords)
    @product = product
    @keywords = keywords
    @title = title
    @description = description
  end

  def generate_description
    response = OpenAI::Client.new.completions(
      parameters: {
        model: SELECTED_MODEL,
        prompt: description_prompt,
        max_tokens: MAX_TOKENS,
        temperature: TEMPERATURE,
        top_p: TOP_P,
        frequency_penalty: FREQUENCY_PENALTY,
        presence_penalty: PRESENCE_PENALTY,
        best_of: BEST_OF
      })

    if response['error'].present?
      raise "OpenAI error: #{response['error']['type']} - #{response['error']['message']}"
    else
      save_response(response)
      response.dig('choices', 0, 'text')
    end
  end

  def description_prompt
    "
      Write a product description with the following requirements:
      - Don't use passive voice
      - Don't write sentences over 20 words
      - Help the buyer make a purchase decision
      - Use conversational and simple language with second person pronouns (\"You\")
      - Don't write filler phrases like \"Great\", \"Very\", \"Really\". Instead write unique product-specific words similar to \"Handmade\", \"Unbreakable\", etc.
      - Should contain the following topics: Features, Advantages, and Benefits
      - Tone of vocabulary should be happy, excited, professional, and friendly

      For context:

      Product description:
      #{@description}

      Product title:
      #{@title}

      Product keywords:
      #{@keywords}
    "
  end

  def save_response(response)
    if @product.openai_generations.create(
      shop_id: @product.shop&.id,
      request_id: response.dig('id'),
      model: response.dig('model'),
      request_type: 'descriptions',
      prompt: description_prompt,
      content: response.dig('choices', 0, 'text'),
      prompt_cost: response.dig('usage', 'prompt_tokens'),
      completion_cost: response.dig('usage', 'completion_tokens'),
      word_count: response.dig('choices', 0, 'text').split(' ').count
    )
      @product.update_attribute(:description_generated, true)
    end
  end
end
