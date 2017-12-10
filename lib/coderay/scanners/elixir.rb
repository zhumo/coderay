module CodeRay
module Scanners
  
  class Elixir < Scanner
    
    register_for :elixir
    file_extension 'ex'
    
  protected
    def setup
      @state = :initial
    end
    
    def scan_tokens encoder, options

      until eos?
        case state
        when :initial
          if match = scan(/[ ]+/x)
            encoder.text_token match, :space
          elsif match = scan(/\n/x)
            encoder.text_token match, :char
          elsif match = scan(/ defmodule /x)
            encoder.text_token match, :keyword
          elsif match = scan(/ do /x)
            encoder.text_token match, :keyword
          elsif match = scan(/ end /x)
            encoder.text_token match, :keyword
          elsif match = scan(/\w+/x)
            encoder.text_token match, :content
          else
            puts "=============="
            puts getch
            puts "=============="
          end
        end
      end

      encoder
    end
    
  end
  
end
end
