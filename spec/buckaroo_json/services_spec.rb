require 'buckaroo_json/services'

describe BuckarooJson::Services do
  describe '.convert' do
    it 'transforms input into Buckaroo-proof parameters' do
      input = [
        {
          'Name' => 'payperemail',
          'Action' => 'PaymentInvitation',
          'customergender' => 9
        }
      ]
      output = {
        'ServiceList' => [
          'Name' => 'payperemail',
          'Action' => 'PaymentInvitation',
          'Parameters' => [
            {
              'Name' => 'customergender',
              'Value' => 9
            }
          ]
        ]
      }
      expect(described_class.convert(input)).to eq(output)
    end
  end
end
