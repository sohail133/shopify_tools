class Openai::MarketingPrompts
  attr_reader :name, :description, :post, :keywords, :tone_of_voice, :request_type

  def call(name:, description:, tone_of_voice:, post:, keywords:, request_type:)
    @name = name
    @description = description
    @post = post
    @keywords = keywords
    @tone_of_voice = tone_of_voice
    @request_type = request_type

    send(request_type)
  end

  private

  def facebook_ad_headline
    <<~PROMPT
      Write the headline for a Facebook advertisement regarding a product.
      - Make the first word the imperative form of a verb.
      - State what is the benefit or outcome of acting.
      - Focus on a single, specific thought.
      - Use numerals and special characters.
      - Communicate empathy.
      - Try to imply the product is "new".
      - Don't include any information that is not part of the product.
      - Ask a question.
      - Communicate the command or action you want people to take upfront.
      - List a benefit
      - Inspire curiosity
      - Use a #{@tone_of_voice} TONE_OF_VOICE tone of vocabulary
      - Keep in between 25-100 characters.
      
      The product of this ad is the following:
      Title: #{@name}
      Description: #{@description}

    PROMPT
  end

  def facebook_ad_primary_text
    <<~PROMPT
      Write the post text for a Facebook advertisement, regarding a product.
      - Give your text a single goal, and stick to it.
      - Find a hook for the buyer.
      - Start your text by saying the opposite of what people believe to be true, without being factually wrong.
      - Disrupt expectations by changing a cliche.
      - Help the buyer imagine, "What if?"
      - Use a #{@tone_of_voice} tone of vocabulary.
      - Keep in between 125-300 characters.

      The product of this ad is the following:
      Title: #{@name}
      Description: #{@description}

    PROMPT
  end

  def instagram_post_caption
    <<~PROMPT
    Write the caption for an Instagram advertisement, about a product.
    - Keep post captions short and precise (under 200 characters).
    - Make a clear offering and pitch only a single idea.
    - Align ad content with the CTA of the ad.
    - Create urgency using phrases like "limited time" and "ends soon".
    - Use a #{@tone_of_voice} tone of vocabulary.
    - The end of the advertisement should contain trending & relevant hashtags (all lowercase)    
    
    Description of the advertisement: #{@post}

    The product of this ad is the following:
    Title: #{@name}
    Description: #{@description}

    Caption:

    PROMPT
  end

  def google_headlines
    <<~PROMPT
    Write the headline for a Google advertisement, about a product.
    - Avoid sounding generic. Use creative language and be unique.
    - Character count should be 30-50.
    - Use a #{@tone_of_voice} tone of vocabulary.
    - Use words that will get the user to click on the ad ("discover", "find out", "get", "learn", etc).
    - Use at least 1 keyword from the product description.
    
    The product of this ad is the following:
    Title: #{@name}
    Description: #{@description}
    
    Ad Headline:

    PROMPT
  end


  def google_descriptions
    <<~PROMPT
    Write the description for a Google advertisement, about a product.
    - Avoid sounding generic. Use creative language and be unique.
    - Character limit is 125.
    - Use a #{@tone_of_voice} tone of vocabulary.
    - Use words that will get the user to click on the ad ("discover", "find out", "get", "learn", etc).
    - Include some product features/benefits from the product description.
    - Follow the description with a Call to Action.
    
    The nature of the product is: #{@post}
    
    The product of this ad is the following:
    Title: #{@name}
    Description: #{@description}
    
    Ad Description:

    PROMPT
  end

  def tiktok
    <<~PROMPT
    Write the caption for a Tiktok advertisement, about a product.
    - Avoid misinformation. The caption should only contain legitimate information about the product.
    - Character limit is 100 characters.
    - Avoid exaggerations and words like "The best," "The most" & "No.1"
    - Use a #{@tone_of_voice} tone of vocabulary.

    The nature of the product is: #{@post}
    
    Title: #{@name}
    Description: #{@description}

    PROMPT
  end


  def pinterest
    <<~PROMPT
    Write a pinterest_pin pin, about a product.
    - Avoid sounding generic. Use creative language and be unique.
    - Character limit is 100.
    - Use a persuasive tone of vocabulary.
    - Talk about the benefits or key features of the products
    - Feel free to use any of the following keywords #{@keywords}.
    
    The product of this ad is the following:
    Title: #{@name}
    Description: #{@description}
    
    Pin:

    PROMPT
  end
end
