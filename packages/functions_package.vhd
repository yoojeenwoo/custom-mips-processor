package functions_package is

function clog2 (num : positive) return positive;

end package;

package body functions_package is

function clog2 (num : positive) return natural is
	variable x 		: positive := 1;
	variable result	: natural := 1;
begin
	while (x < num) loop
		x := x * 2;
		result := result + 1;
	end loop;
	return result;
end function;

end package body;