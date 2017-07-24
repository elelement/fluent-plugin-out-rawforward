require 'test/unit'

require 'fluent/test'
require 'fluent/plugin/out_rawforward'

require 'webmock/test_unit'
require 'date'

require 'helper'

$:.push File.expand_path("../lib", __FILE__)
$:.push File.dirname(__FILE__)

WebMock.disable_net_connect!

class TestRawForwardTcpOutput < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    stub_socket
    @driver = driver('test', "<server>
                                      host 127.0.0.1
                                      port 24225
                              </server>")
  end

  def driver(tag='test', conf='')
    @driver ||= Fluent::Test::BufferedOutputTestDriver.new(Fluent::RawForwardTCPOutput, tag).configure(conf)
  end

  def sample_record
    {'log' => 'put example_3_2_movement_door 1500912863 0 name=movement_door type=3 device=3 uc=example'}
  end

  def stub_socket
    server = TCPServer.new 24225
    Thread.start do
      loop do
        Thread.start(server.accept) do |client|
          while (b = client.read)
            puts ">> #{b}"
          end
          client.close
        end
      end
    end
  end

  def test_writes_to_default_index
    100.times.each do |t|
      @driver.emit(sample_record)
    end
    @driver.run
  end
end
