module ActionDispatch
  class Cookies
    class SignedCookieJar 
     def []=(key, options)
        if options.is_a?(Hash)
          options.symbolize_keys!
          GL.info('SESSION_DUMP_BEFORE_GENERATE hash ' + options[:value].inspect)
          options[:value] = @verifier.generate(options[:value])
          GL.info('SESSION_DUMP_POST_GENERATE hash ' + options[:value].inspect)
        else
          GL.info('SESSION_DUMP_BEFORE_GENERATE nonhash ' + options.inspect)
          options = { :value => @verifier.generate(options) }
          GL.info('SESSION_DUMP_POST_GENERATE nonhash ' + options[:value].inspect)
        end

        raise CookieOverflow if options[:value].size > MAX_COOKIE_SIZE
        @parent_jar[key] = options
      end
    end
  end
end