library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SevenSegment_Package.all;

entity Memory_File is
    generic (
        INIT_STRING : string := "Ahoj  " --! Initial memory content
    );
    port (
        address  : in integer range 0 to length(INIT_STRING) - 1; --! Memory address
        data_out : out byte --! Data output
    );
end Memory_File;

architecture Behavioral of Memory_File is
    --! Memory type
    type memory_array is array(0 to length(INIT_STRING) - 1) of byte;

    --! function to initialize memory content
    function init_memory(DATA_WIDTH : in integer) return memory_array is
        variable temp_mem               : memory_array;
    begin
        for i in MEMORY_ARRAY'range loop
            temp_mem(i) := char_to_byte(INIT_STRING(i));
        end loop;
        return temp_mem;
    end function;
    --! ROM memory
    constant memory_content : memory_array := init_memory(DATA_WIDTH);
begin
    memory :
    process (clk) is
    begin
        if rising_edge(clk) then
            data_out <= memory_content(address);
        end if;
    end process;
end Behavioral;