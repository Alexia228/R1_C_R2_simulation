
function Array = switch_foo(Array, Probability)

Range_part = Array == Probability.from;
Part = Array(Range_part);
if ~isempty(Part)
    Dice = rand(size(Part));
    Probability2switch = Probability.p;
    range = Dice < Probability2switch;
    Part(range) = Probability.to;
    Array(Range_part) = Part;
end

end
