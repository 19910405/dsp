require 'spec_helper'

describe ::DSP::TEA do
  
  context '#decrypt' do
    it 'decrypt price for rdx and return normal price' do
    	key = '123456789abcdefg'
    	encryptedStr = 'J+qNGSqDrwK/QL3CE3t48jghTr0LdsJ3'
    	res = ::DSP::TEA.decryptString(encryptedStr, key)
    	expect(res).to eq "06.00000"
    end
  end
end
