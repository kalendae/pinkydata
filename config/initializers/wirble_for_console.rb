module Rails
  class Console

    def initialize(app)
      @app = app
      # Wirble for console
      Wirble.init
      Wirble.colorize
    end
  
  end
end
