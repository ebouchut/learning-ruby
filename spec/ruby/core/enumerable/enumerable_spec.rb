describe "Enumerable" do

  let(:digits) do
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  end



  context "#any?" do
    it "returns true if the block is true for at least one item" do
      expect(digits.any? {|n| n.even?}).to be_true
    end
  end


  context "#chunk" do
    context "when given a block" do
      pending
    end
  end


  context "#collect_concat (alias #flat_map)" do

    context "when given a block" do
      it "returns a new array with the concatenated results of running block once for every element in enum." do
        expect( [[1, 2], [3, 4]].collect_concat {|array| array}).to eq( [1, 2, 3, 4])
      end 
    end

    context "if no  block is given" do
      it "returns an enumerator" do
        enum = [[1, 2], [3, 4]].collect_concat

        expect(enum).to be_instance_of(Enumerator)
        expect(enum.next).to eq([1, 2])
        expect(enum.next).to eq([3, 4])
      end
    end
  end


  context "#count" do

    context "with no parameter" do
      it "count the number of items in the enumeration" do
        expect(digits.count).to eq(10)
      end
    end
    context "when given a parameter (n)" do
      it "count the number of items in the enumeration, for which equals to n" do
        expect([1, 2, 3, 2].count(2)).to eq(2)
      end 

    end
    context "when given a block" do
      it "count the number of items, for which the block yields a true value" do
        expect(digits.count {|n| n > 5}).to eq(4)
      end
    end
  end


  context "#cycle" do

    context "when given a parameter (n) and no block" do
      it "returns an enumerator" do
        whatever_n = 2
        enum = [1, 2, 3].cycle(whatever_n)        
        expect(enum).to be_instance_of(Enumerator)
        expect(enum.next).to eq(1)
        expect(enum.next).to eq(2)
      end
    end

    context "when given a block" do
      it "calls the block repeatedly" do
        pending "How to test this effectively?"
      end

      context "when also given a parameter (n)" do
        it "calls the block repeatly n times" do
          sum = 0 
          digits.cycle(2) {|n| sum += n}
          expect(sum).to eq(2 * digits.reduce(:+))
        end 

        it "does nothing if n is negative (< 0)" do
          sum = 0
          digits.cycle(-5) {|n| sum += n}
          expect(sum).to eq(0)
        end

        it "does nothing if the collection is empty" do
          sum = 0
          [].cycle(5) {|n| sum += n}
          expect(sum).to eq(0)
        end

        it "calls the block repeatedly if n is nil"

        it "returns nil if the loop has finished without getting interrupted" do
          expect(digits.cycle(5) {}).to be_nil
        end
      end 
    end
  end

  context "#find (alias #detect)" do
    context "when given a block" do 
      it "returns the first item for which the block is true" do
        expect(digits.find {|n| n > 5}).to eq(6)
      end
      it "returns the result of the call to passed in proc of lambda in cases where no object in the collection matches the criteria." do
      end
    end 
    context "when no block is given" do
      it "returns an Enumerator"
    end
  end


  context "#select (alias #find_all)" do
    context "when given a block" do
      it "returns the items for which the block is true" do
        expect(digits.select {|n| n > 5}).to eq([6, 7, 8, 9])
      end
    end
  end 


  context "#map (alias #collect)" do

    context "when given a block" do
      it "returns an array with the values of the block" do
        expect(digits.map {|n| n * 2 }).to eq( [0, 2, 4, 6, 8, 10, 12, 14, 16, 18])
      end
    end

    context "if no block is given" do
      it "returns an Enumerator" do
        enum = digits.map

        expect(enum).to be_instance_of(Enumerator) 
        10.times do |n|
          expect(enum.next).to eq(n)
        end
      end
    end
  end

end
