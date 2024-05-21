library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Package pro práci s 7-segmentovým displejem <br>
--! Obsahuje funkce pro převod znaku na ASCII hodnotu a naopak, 
--! funkci pro převod ASCII hodnoty na 7-segmentový kód.

package SevenSegment_Package is
    subtype byte is std_logic_vector(7 downto 0);

    --! 3-state output buffer.
    function tri_state_output (value : std_logic; out_enable : std_logic) return std_logic;

    --! Conversion Boolean to std_logic
    function to_std_logic(bool : boolean) return std_logic;

    function char_to_byte(c      : character) return byte;
    function byte_to_character(b : byte) return character;

    function convert_char_to_7seg(input_char : std_logic_vector(7 downto 0)) return std_logic_vector;
end package;

package body SevenSegment_Package is
    function tri_state_output (value : std_logic; out_enable : std_logic) return std_logic is
        variable output : std_logic;
    begin
        if out_enable = '1' then
            output := value;
        else
            output := 'Z';
        end if;
        return output;
    end function;

    function to_std_logic(bool : boolean) return std_logic is
        begin
            if bool = false then
                return '0';
            else
                return '1';
            end if;
        end function to_std_logic;

    function char_to_byte(c : character) return byte is
    begin
        return byte(to_unsigned(character'pos(c), 8));
    end function;

    function byte_to_character(b : byte) return character is
    begin
        return character'val(to_integer(unsigned(b)));
    end function;

    function convert_char_to_7seg(input_char : std_logic_vector(7 downto 0)) return std_logic_vector is
    begin
        case input_char is
            when "00100000" => return "0000000"; -- space
            when "00100001" => return "0110000"; -- !
            when "00100010" => return "0111011"; -- "
            when "00100011" => return "0000000"; -- #
            when "00100100" => return "0000000"; -- $
            when "00100101" => return "0000000"; -- %
            when "00100110" => return "0000000"; -- &
            when "00100111" => return "0001000"; -- '
            when "00101000" => return "0000000"; -- (
            when "00101001" => return "0000000"; -- )
            when "00101010" => return "0000000"; -- *
            when "00101011" => return "1111001"; -- +
            when "00101100" => return "0000001"; -- ,
            when "00101101" => return "1000000"; -- -
            when "00101110" => return "0000001"; -- .
            when "00101111" => return "0000000"; -- /
            when "00110000" => return "1111110"; -- 0
            when "00110001" => return "0110000"; -- 1
            when "00110010" => return "1101101"; -- 2
            when "00110011" => return "1111001"; -- 3
            when "00110100" => return "0110011"; -- 4
            when "00110101" => return "1011011"; -- 5
            when "00110110" => return "1011111"; -- 6
            when "00110111" => return "1110000"; -- 7
            when "00111000" => return "1111111"; -- 8
            when "00111001" => return "1111011"; -- 9
            when "00111010" => return "0000000"; -- :
            when "00111011" => return "0000000"; -- ;
            when "00111100" => return "0000000"; -- <
            when "00111101" => return "1000000"; -- =
            when "00111110" => return "0000000"; -- >
            when "00111111" => return "0000000"; -- ?
            when "01000000" => return "0000000"; -- @
            when "01000001" => return "0000001"; -- A
            when "01000010" => return "1001111"; -- B
            when "01000011" => return "1100110"; -- C
            when "01000100" => return "0111101"; -- D
            when "01000101" => return "1001110"; -- E
            when "01000110" => return "1000110"; -- F
            when "01000111" => return "1011110"; -- G
            when "01001000" => return "0111011"; -- H
            when "01001001" => return "0110000"; -- I
            when "01001010" => return "0111100"; -- J
            when "01001011" => return "1111010"; -- K
            when "01001100" => return "0001111"; -- L
            when "01001101" => return "0101010"; -- M
            when "01001110" => return "1101010"; -- N
            when "01001111" => return "1111010"; -- O
            when "01010000" => return "1000111"; -- P
            when "01010001" => return "1101101"; -- Q
            when "01010010" => return "1000010"; -- R
            when "01010011" => return "1011011"; -- S
            when "01010100" => return "1000000"; -- T
            when "01010101" => return "0111110"; -- U
            when "01010110" => return "1111000"; -- V
            when "01010111" => return "0101010"; -- W
            when "01011000" => return "1111011"; -- X
            when "01011001" => return "1101110"; -- Y
            when "01011010" => return "0110011"; -- Z
            when "01011011" => return "0000000"; -- [
            when "01011100" => return "0000000"; -- '\'
            when "01011101" => return "0000000"; -- ]
            when "01011110" => return "0000000"; -- ^
            when "01011111" => return "0001000"; -- _
            when "01100000" => return "0000000"; -- `
            when "01100001" => return "0000001"; -- a
            when "01100010" => return "1001111"; -- b
            when "01100011" => return "1100110"; -- c
            when "01100100" => return "0111101"; -- d
            when "01100101" => return "1001110"; -- e
            when "01100110" => return "1000110"; -- f
            when "01100111" => return "1011110"; -- g
            when "01101000" => return "0111011"; -- h
            when "01101001" => return "0110000"; -- i
            when "01101010" => return "0111100"; -- j
            when "01101011" => return "1111010"; -- k
            when "01101100" => return "0001111"; -- l
            when "01101101" => return "0101010"; -- m
            when "01101110" => return "1101010"; -- n
            when "01101111" => return "1111010"; -- o
            when "01110000" => return "1000111"; -- p
            when "01110001" => return "1101101"; -- q
            when "01110010" => return "1000010"; -- r
            when "01110011" => return "1011011"; -- s
            when "01110100" => return "1000000"; -- t
            when "01110101" => return "0111110"; -- u
            when "01110110" => return "1111000"; -- v
            when "01110111" => return "0101010"; -- w
            when "01111000" => return "1111011"; -- x
            when "01111001" => return "1101110"; -- y
            when "01111010" => return "0110011"; -- z
            when "01111011" => return "0000000"; -- {
            when "01111100" => return "0000000"; -- |
            when "01111101" => return "0000000"; -- }
            when "01111110" => return "0000000"; -- ~
            when others     => return "1111111"; -- Výchozí hodnota pro neznámé znaky
        end case;
    end function;

end package body;