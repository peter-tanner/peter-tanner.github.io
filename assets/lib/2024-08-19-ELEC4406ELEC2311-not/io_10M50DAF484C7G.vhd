library ieee;
use ieee.std_logic_1164.all;

entity io_10M50DAF484C7G is
    port (
        CLK_IN_50MHz                                                         : in std_logic;
        KEY0, KEY1                                                           : in std_logic;
        SW0_9                                                                : in std_logic_vector(8 downto 0);
        SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9                     : in std_logic;
        LEDR0_9                                                              : out std_logic_vector(8 downto 0);
        LEDR0, LEDR1, LEDR2, LEDR3, LEDR4, LEDR5, LEDR6, LEDR7, LEDR8, LEDR9 : out std_logic;
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5                                   : out std_logic_vector(6 downto 0);
        HEX0_DP, HEX1_DP, HEX2_DP, HEX3_DP, HEX4_DP, HEX5_DP                 : out std_logic
    );
end entity;

architecture rtl of io_10M50DAF484C7G is
    attribute chip_pin : string; -- MUST BE DECLARED.
    ---------------------
    -- 50 MHz CLOCK IN --
    ---------------------
    attribute chip_pin of CLK_IN_50MHz : signal is "P11";

    ----------------------
    -- TACTILE SWITCHES --
    ----------------------
    -- IMPORTANT: YOU MUST SET THE INPUT TYPE TO "2.5V Schmitt trigger I/O standard" TO DEBOUNCE.
    -- Behavior: HIGH (Pullup)
    attribute chip_pin of KEY0 : signal is "B8";
    attribute chip_pin of KEY1 : signal is "A7";

    ---------------------
    -- TOGGLE SWITCHES --
    ---------------------
    -- SINGLE VECTOR
    attribute chip_pin of SW0_9 : signal is "C10 C11 D12 C12 A12 B12 A13 A14 B14 F15";
    -- MULTIPLE
    attribute chip_pin of SW0 : signal is "C10";
    attribute chip_pin of SW1 : signal is "C11";
    attribute chip_pin of SW2 : signal is "D12";
    attribute chip_pin of SW3 : signal is "C12";
    attribute chip_pin of SW4 : signal is "A12";
    attribute chip_pin of SW5 : signal is "B12";
    attribute chip_pin of SW6 : signal is "A13";
    attribute chip_pin of SW7 : signal is "A14";
    attribute chip_pin of SW8 : signal is "B14";
    attribute chip_pin of SW9 : signal is "F15";

    ----------
    -- LEDS --
    ----------
    -- SINGLE VECTOR
    attribute chip_pin of LEDR0_9 : signal is "A8 A9 A10 B10 D13 C13 E14 D14 A11 B11";
    -- MULTIPLE OUTPUTS
    attribute chip_pin of LEDR0 : signal is "A8";
    attribute chip_pin of LEDR1 : signal is "A9";
    attribute chip_pin of LEDR2 : signal is "A10";
    attribute chip_pin of LEDR3 : signal is "B10";
    attribute chip_pin of LEDR4 : signal is "D13";
    attribute chip_pin of LEDR5 : signal is "C13";
    attribute chip_pin of LEDR6 : signal is "E14";
    attribute chip_pin of LEDR7 : signal is "D14";
    attribute chip_pin of LEDR8 : signal is "A11";
    attribute chip_pin of LEDR9 : signal is "B11";

    ------------------
    -- HEX DISPLAYS --
    ------------------
    attribute chip_pin of HEX0    : signal is "C14 E15 C15 C16 E16 D17 C17";
    attribute chip_pin of HEX0_DP : signal is "D15"; -- DECIMAL POINT
    attribute chip_pin of HEX1    : signal is "C18 D18 E18 B16 A17 A18 B17";
    attribute chip_pin of HEX1_DP : signal is "A16"; -- DECIMAL POINT
    attribute chip_pin of HEX2    : signal is "B20 A20 B19 A21 B21 C22 B22";
    attribute chip_pin of HEX2_DP : signal is "A19"; -- DECIMAL POINT
    attribute chip_pin of HEX3    : signal is "F21 E22 E21 C19 C20 D19 E17";
    attribute chip_pin of HEX3_DP : signal is "D22"; -- DECIMAL POINT
    attribute chip_pin of HEX4    : signal is "F18 E20 E19 J18 H19 F19 F20";
    attribute chip_pin of HEX4_DP : signal is "F17"; -- DECIMAL POINT
    attribute chip_pin of HEX5    : signal is "J20 K20 L18 N18 M20 N19 N20";
    attribute chip_pin of HEX5_DP : signal is "L19"; -- DECIMAL POINT
begin
end architecture;