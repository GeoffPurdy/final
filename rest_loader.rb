require 'net/http'

url = 'http://0.0.0.0:3000/words/'
params = {
    'name' => 'pool'
}

resp = Net::HTTP.post_form(url, params)

resp_text = resp.body
