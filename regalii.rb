require 'json'
require 'pry'
require 'base64'
require 'unirest'


class RegaliiAverageCalculator

  def initialize
    @request_headers = { 'Content-Type' => 'application/json' }
    @hostname = 'https://deudas.herokuapp.com/accounts'
  end

  def average
    bills_size = bills.size
    total = bills.inject(0.0) do |total, bill|
      total + bill_value(bill)
    end

    post_average(total / bills_size)
  end

  private def bill_value(bill)
    Base64.decode64(bill['amount']).tr('$', '').to_f
  end

  private def post_average(average)
    parameters = { average: average }
    Unirest.put("https://deudas.herokuapp.com/accounts/#{@uuid}", headers: @request_headers, parameters: parameters)
  end

  private def bills
    return @bills unless @bills.nil?

    parameters = {
      name: 'Michael Romano',
      email: 'micha7a.com@gmail.com'
    }

    response = Unirest.post(@hostname, headers: @request_headers, parameters: parameters)

    @uuid = response.body['uuid']
    @bills = [
      {"type"=>"bill", "statement_date"=>"2016-12-10", "amount"=>"NzYuMA==\n"},
      {"type"=>"bill", "statement_date"=>"2017-01-10", "amount"=>"JDE0LjE=\n"},
      {"type"=>"bill", "statement_date"=>"2017-02-10", "amount"=>"NjUuMg==\n"},
      {"type"=>"bill", "statement_date"=>"2017-03-10", "amount"=>"JDE2Ni4z\n"}
    ]
    # response.body['bills']
  end

end

calculator = RegaliiAverageCalculator.new
calculator.average