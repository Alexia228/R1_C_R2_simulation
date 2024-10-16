function Array = switch_foo(Array, value, Probability)

Range_part = Array == value;
Part = Array(Range_part);
Dice = rand(size(Part));
range = Dice < Probability;
Part(range) = -value;
Array(Range_part) = Part;

end


