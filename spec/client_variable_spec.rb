require "spec_helper"

describe ClientVariable do
	describe '.generate' do
	  it 'should be type of hash' do
	  	Rails.stub(:root) { ''}
			expect(ClientVariable.generate).to be_kind_of(Hash)
	  end
	end
end
