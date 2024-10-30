function Array = switch_foo(Array, Probability)

Range_part = Array == Probability.from; %Тут будут нули?
Part = Array(Range_part);
Dice = rand(size(Part));
range = Dice < Probability.p;
Part(range) = Probability.to;
Array(Range_part) = Part;

end


