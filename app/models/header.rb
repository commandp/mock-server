# == Schema Information
#
# Table name: headers
#
#  id             :integer          not null, primary key
#  key            :string
#  value          :text
#  api_request_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_headers_on_api_request_id  (api_request_id)
#
# Foreign Keys
#
#  fk_rails_117843eff4  (api_request_id => api_requests.id)
#

class Header < ApplicationRecord

  belongs_to :api_request
  validates_presence_of :key, :value

  BASIC_HEADERS = [
    'Accept',
    'Accept-Charset',
    'Accept-Encoding',
    'Accept-Language',
    'Accept-Datetime',
    'Authorization',
    'Cache-Control',
    'Connection',
    'Cookie',
    'Content-Length',
    'Content-MD5',
    'Content-Type',
    'Date',
    'Expect',
    'Forwarded',
    'From',
    'Host',
    'If-Match',
    'If-Modified-Since',
    'If-None-Match',
    'If-Range',
    'If-Unmodified-Since',
    'Max-Forwards',
    'Origin',
    'Pragma',
    'Proxy-Authorization',
    'Range',
    'Referer',
    'TE',
    'User-Agent',
    'Upgrade',
    'Via',
    'Warning'
  ]

end
