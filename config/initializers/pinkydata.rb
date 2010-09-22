GL = ::Rails.logger  # Global Logger

FB_APP_ID = 120527154669149
FB_SECRET = '8c7dbb67e757f2a10804c08ed038303b'
PINKYDATA_ROOT = 'http://www.pinkydata.com:3008'
APP_URL_ROOT = 'http://apps.facebook.com/pinkydata'
CALLBACK_URL = APP_URL_ROOT + "/go/cb"

OAUTH = Koala::Facebook::OAuth.new(FB_APP_ID, FB_SECRET, CALLBACK_URL)