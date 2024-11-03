# frozen_string_literal: true

RSpec.describe Proptypes do
  describe described_class::StringOrNil do
    describe "#call" do
      it "returns nil for nil" do
        expect(subject.call(nil)).to be_nil
      end

      it "returns the input for a string" do
        expect(subject.call("foo")).to eq("foo")
      end

      it "coerces the input to a string" do
        expect(subject.call(42)).to eq("42")
      end
    end
  end

  describe described_class::IntegerOrNil do
    describe "#call" do
      it "returns nil for nil" do
        expect(subject.call(nil)).to be_nil
      end

      it "returns the input for an integer" do
        expect(subject.call(42)).to eq(42)
      end

      it "coerces the input to an integer" do
        expect(subject.call("42")).to eq(42)
      end
    end
  end

  describe described_class::BoolOrNil do
    describe "#call" do
      it "returns nil for nil" do
        expect(subject.call(nil)).to be_nil
      end

      it "returns the input for a boolean" do
        expect(subject.call(true)).to eq(true)
      end

      it "coerces the input to a boolean" do
        expect(subject.call("true")).to eq(true)
      end
    end
  end

  describe described_class::HashOrNil do
    describe "#call" do
      it "returns nil for nil" do
        expect(subject.call(nil)).to be_nil
      end

      it "returns the input for a hash" do
        expect(subject.call({})).to eq({})
      end
    end
  end

  describe described_class::SymbolOrNil do
    describe "#call" do
      it "returns nil for nil" do
        expect(subject.call(nil)).to be_nil
      end

      it "returns the input for a symbol" do
        expect(subject.call(:foo)).to eq(:foo)
      end

      it "coerces the input to a symbol" do
        expect(subject.call("foo")).to eq(:foo)
      end
    end
  end

  describe described_class::HtmlTag do
    describe "#call" do
      it "returns :div for nil" do
        expect(subject.call(nil)).to eq(:div)
      end

      it "returns the input for a valid HTML tag" do
        expect(subject.call(:span)).to eq(:span)
      end

      it "raises an error for an invalid HTML tag" do
        expect { subject.call(:foo) }.to raise_error(Dry::Types::CoercionError)
      end
    end
  end

  describe described_class::Option do
    describe "#call" do
      it "returns the input for a non-callable value" do
        expect(subject.call(42)).to eq(42)
      end

      it "calls the input for a callable value" do
        expect(subject.call(-> { 42 })).to eq(42)
      end
    end
  end

  describe described_class::EnumOption do
    describe "#en" do
      it "returns the input for a nil value" do
        expect(subject.enum(:foo, :bar).call(nil)).to be_nil
      end

      it "can get values from a block" do
        expect(subject.enum { %i[foo bar] }.call(:foo)).to eq(:foo)
      end

      it "can get values from a block and validate a proc" do
        value = proc { :bar }
        expect((subject.enum { %i[foo bar] }.call(value))).to eq(:bar)
      end

      it "raises an error for an invalid value" do
        expect { subject.enum(:foo, :bar).call(:baz) }.to raise_error(Dry::Types::ConstraintError)
      end

      it "raises an error for an invalid value from a block" do
        expect { subject.enum { %i[foo bar] }.call(:baz) }.to raise_error(Dry::Types::ConstraintError)
      end

      it "raises an error for an invalid value from a block and validate a proc" do
        value = proc { :baz }
        expect { (subject.enum { %i[foo bar] }.call(value)) }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end
end
