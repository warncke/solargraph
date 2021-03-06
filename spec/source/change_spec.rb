describe Solargraph::Source::Change do
  it "inserts a character" do
    text = 'var'
    range = Solargraph::Source::Range.from_to(0, 3, 0, 3)
    new_text = '.'
    change = Solargraph::Source::Change.new(range, new_text)
    updated = change.write(text)
    expect(updated).to eq('var.')
  end

  it "repairs nullable characters" do
    text = 'var'
    range = Solargraph::Source::Range.from_to(0, 3, 0, 3)
    new_text = '.'
    change = Solargraph::Source::Change.new(range, new_text)
    updated = change.write(text, true)
    expect(updated).to eq('var ')
  end

  it "repairs entire changes" do
    text = 'var'
    range = Solargraph::Source::Range.from_to(0, 3, 0, 3)
    new_text = '._(!'
    change = Solargraph::Source::Change.new(range, new_text)
    updated = change.repair(text)
    expect(updated).to eq('var    ')
  end

  it "overwrites for nil ranges" do
    text = 'foo'
    new_text = 'bar'
    change = Solargraph::Source::Change.new(nil, new_text)
    updated = change.write(text)
    expect(updated).to eq('bar')
  end

  it "blanks single colons in nullable changes" do
    text = 'bar'
    new_text = ':'
    range = Solargraph::Source::Range.from_to(0, 3, 0, 3)
    change = Solargraph::Source::Change.new(range, new_text)
    updated = change.write(text, true)
    expect(updated).to eq('bar ')
  end

  it "blanks double colons in nullable changes" do
    text = 'bar:'
    new_text = ':'
    range = Solargraph::Source::Range.from_to(0, 4, 0, 4)
    change = Solargraph::Source::Change.new(range, new_text)
    updated = change.write(text, true)
    expect(updated).to eq('bar  ')
  end
end
