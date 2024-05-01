library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SevenSegment_Package.all;

entity Memory_File is
    generic
    (
        INIT_STRING : string := "Ahoj  " --! Initial memory content
    );
    port
    (
        address  : in integer range 0 to length(INIT_STRING) - 1; --! Memory address
        data_out : out byte --! Data output
    );
end Memory_File;

architecture Behavioral of Memory_File is
    type memory_array is array(0 to length(INIT_STRING) - 1) of byte;
    constant memory_content : memory_array := (
    for i in 0 to length(INIT_STRING) - 1 generate
        char_to_byte(INIT_STRING(i));
    end generate
    );
begin
    data_out <= memory_content(address);
end Behavioral;