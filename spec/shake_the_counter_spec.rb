RSpec.describe ShakeTheCounter do
  it "has a version number" do
    expect(ShakeTheCounter::VERSION).not_to be nil
  end

  it "is verbose by default" do
    expect(ShakeTheCounter::Config.verbose).to be true
  end

end
