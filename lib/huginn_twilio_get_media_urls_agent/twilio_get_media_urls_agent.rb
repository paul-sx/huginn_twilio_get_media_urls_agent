module Agents
  class TwilioGetMediaUrlsAgent < Agent
    cannot_be_scheduled!
    no_bulk_receive!

    description <<-MD
      This agent takes the output of a conversation onMessageEvent and looks for a 'Media' Key.  If it doesn't find one it passes the event on to the next agent.  If it does find one it performs web API calls to Twilio to convert the Sid's into temporary direct access URLs, which it places into a 'temp_links' key it adds to the original event.
      `chat_sid` is the Twilio chat service SID that is being used.
    MD

    def default_options
      {
        'account_sid' => '{% credential twilio_account_sid %}',
        'auth_token' => '{% credential twilio_auth_token %}',
        'chat_sid' => 'ISXXXXXXXXXX'
      }
    end

    def validate_options
      unless options['account_sid'].present? && options['auth_token'].present? && options['chat_sid'].present?
        errors.add(:base, "Account_sid, auth_token, and chat_sid all required.")
      end
    end

#    def check
#    end

    def receive(incoming_events)
      interpolate_with_each(incoming_events) do |event|
        if event.payload['Media'].present?
          links = event.payload['Media'].each_with_object([]) do |h, l|
            link = get_link(h['Sid'])
            l << link if link
          end
          event.payload['temp_links'] = links
          create_event(payload: event.payload)
        else
          # Pass event untouched if Media is not present
          create_event(payload: event.payload)
        end
      end
    end

    def get_link(media_sid)
      response = client.get("/v1/Services/#{interpolated['chat_sid']}/Media/#{media_sid}")
      if response.status == 200
        data = JSON.parse response.body
        return data['links']['content_direct_temporary']
      end
      nil
    end

    def client
      @client ||= Faraday.new(url: 'https://mcs.us1.twilio.com') do |builder|
        builder.request :retry
        builder.request :basic_auth interpolated['account_sid'], interpolated['auth_token']
        builder.adapter :net_http
      end
    end
  end
end
