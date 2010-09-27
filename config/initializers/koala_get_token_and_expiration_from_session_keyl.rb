module Koala
  module Facebook
    class OAuth

      def get_tokens_and_expiration_from_session_keys(sessions)
        # get the original hash results
        results = get_token_info_from_session_keys(sessions)
        # now recollect them as just the access tokens
        results.collect { |r| r ? {:token => r["access_token"], :expires => Time.at(r["expires"])} : nil }
      end

      def get_token_and_expiration_from_session_key(session)
        # convenience method for a single key
        # gets the overlaoded strings automatically
        get_tokens_and_expiration_from_session_keys([session])[0]
      end

    end
  end
end