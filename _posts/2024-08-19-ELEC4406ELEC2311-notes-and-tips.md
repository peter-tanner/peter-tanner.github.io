---
title: ELEC4406/ELEC2311 notes and tips
author: peter
date: 2024-08-19 02:26:49 +0800
categories: [Guide, University] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [ELEC4406, vhdl, fpga, digital system design, ELEC2311] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
toc: true
# image: assets/img/2024-08-19-ELEC4406ELEC2311-not/preview.png
---

Some useful notes/code for the class tests 1 and 2, the lab test and exam.

## Lab test tips

The lab test has a very high time pressure (kind of like comms if you have/are doing it).

### Components to bring

- Bring in components for clock divider, 7 segment display, FSM template, DE10-lite `attribute chip_pin` mappings and all lab materials at the minimum.

### Strategy

- Save time, you will not have enough time for mistakes
- Use `attribute chip_pin` to avoid using the pin planner (saves mouse-clicks and time). See section [`attribute chip_pin` section](#attribute-chip_pin) of this page for pin mappings (adapted from DE10-lite manual).
- Use a mouse, you will not have time for trackpad.
- Focus on getting a working design before moving on to another design, they will only give one mark if your design has code, but you can't demonstrate it working (mock lab test). If your working design has a bug then they don't take too many marks away in my experience (mock lab test: I had a speed switch erroneously affect both speed and direction of a FSM - this only copped a 1 mark penalty in the mock lab test).
- **NOTE: Check for your current year**. As of 2024, you may use your personal computer in the test and you don't need to use the lab computers (subject to same restrictions). You may not use anything other than Altera Quartus, Modelsim and Adobe Acrobat. You _cannot_ use vscode.
- Make a few project files and the directory structure before the test, DO NOT put modelsim project in the same directory as code.

```text
[SID]
  -> SYNTH
    -> Part1
    -> Part2
    ...
  -> SIM
    -> PartN
    ...
```

### Testbenches

- Test top-level block, but modifications can be made to make it more readable for testbench
  - Example: Instead of 50MHz clock_in, make it something more reasonable like 2Hz so the clock divider does not have to pulse 50 million times for one cycle
  - Example: If it has a 7 segment display output instead of testing the display outputs just directly put the number out in the test bench version.
  - Examples from source _Mock Lab test part 2 solutions/Part 3 building the simulation_
- It might be easier just to copy-paste the whole code and change the constants instead of making it generic which needs to be instantiated again

```tcl
# Start simulation and add all waves
vsim $TESTBENCH_ID -voptargs=+acc; add wave *

# Recompile and restart simulation (if file modified)
project compileoutofdate; restart -force; run -all
```

### Syntax checking

You will run into syntax issues one way or another, but the main point is to use the most time-efficient way to find them.

- Enable autocomplete. It's better than nothing, but it's definitely not intellisense.

![Enable autocomplete](/assets/img/2024-08-19-ELEC4406ELEC2311-not/autocomplete.png)

- Use Questasim/Modelsim for syntax checking, a lot of time was wasted in the lab test waiting for quartus analysis to complete to check syntax, whereas modelsim can check it instantly. Use the command `project compileall` in the tcl console if you don't want to right-click > compile all every time you save a file (use up arrow to repeat last command instead of retyping it).
- Double-click a line in the compile results to see the detailed errors for that file\
  Example:

```text
Questa> project compileall
# Compile of clk_div.vhd was successful.
# Compile of fsm.vhd failed with 1 errors. <--- double click on this to see errors in fsm.vhd in a new window
# Compile of part2.vhd was successful.
# Compile of part2_tb.vhd was successful.
# Compile of seven_seg_dec.vhd was successful.
# 5 compiles, 1 failed with 1 error.
```

- In the new window, double-click on an error to move your cursor to that line in modelsim.

```text
vcom -work work -2002 -explicit -vopt -stats=none $PATH/fsm.vhd
Questa Intel Starter FPGA Edition-64 vcom 2023.3 Compiler 2023.07 Jul 17 2023
-- Loading package STANDARD
-- Loading package TEXTIO
-- Loading package std_logic_1164
-- Compiling entity fsm
-- Compiling architecture behavior of fsm
** Error: $PATH/fsm.vhd(16): near "beg": (vcom-1576) expecting BEGIN. <--- double click this error line to view location of error in modelsim.
** Note: $PATH/fsm.vhd(16): VHDL Compiler exiting
```

- I recommend fixing errors in modelsim editor instead of alt-tabbing between modelsim and quartus to fix errors. when going back to quartus you will need to press 'yes' when it asks if you want to overwrite local changes.

## [`attribute chip_pin`](https://www.intel.com/content/www/us/en/programmable/quartushelp/17.0/hdl/vhdl/vhdl_file_dir_chip.htm)

Quick reference for DE10-LITE. [🔗 Download `io_10M50DAF484C7G.vhd`](/assets/lib/2024-08-19-ELEC4406ELEC2311-not/io_10M50DAF484C7G.vhd)

```vhdl
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
    attribute chip_pin of SW9_0 : signal is "F15, B14, A14, A13, B12, A12, C12, D12, C11, C10";
    attribute chip_pin of SW0_9 : signal is "C10, C11, D12, C12, A12, B12, A13, A14, B14, F15";
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
    attribute chip_pin of LEDR9_0 : signal is "B11, A11, D14, E14, C13, D13, B10, A10, A9,  A8";
    attribute chip_pin of LEDR0_9 : signal is "A8,  A9,  A10, B10, D13, C13, E14, D14, A11, B11";

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
    attribute chip_pin of HEX0    : signal is "C17, D17, E16, C16, C15, E15, C14";
    attribute chip_pin of HEX0_DP : signal is "D15"; -- DECIMAL POINT
    attribute chip_pin of HEX1    : signal is "B17, A18, A17, B16, E18, D18, C18";
    attribute chip_pin of HEX1_DP : signal is "A16"; -- DECIMAL POINT
    attribute chip_pin of HEX2    : signal is "B22, C22, B21, A21, B19, A20, B20";
    attribute chip_pin of HEX2_DP : signal is "A19"; -- DECIMAL POINT
    attribute chip_pin of HEX3    : signal is "E17, D19, C20, C19, E21, E22, F21";
    attribute chip_pin of HEX3_DP : signal is "D22"; -- DECIMAL POINT
    attribute chip_pin of HEX4    : signal is "F20, F19, H19, J18, E19, E20, F18";
    attribute chip_pin of HEX4_DP : signal is "F17"; -- DECIMAL POINT
    attribute chip_pin of HEX5    : signal is "N20, N19, M20, N18, L18, K20, J20";
    attribute chip_pin of HEX5_DP : signal is "L19"; -- DECIMAL POINT
```

### Example of usage

```vhdl
architecture rtl of top_level_entity is
    attribute chip_pin : string; -- MUST BE DECLARED.
    attribute chip_pin of X : signal is "A B C ...";
    attribute chip_pin of Y : signal is "Q R S ...";
    ...
begin
```

## fsm template

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity fsm is
    port (
        clk, nrst_async, x  : in std_logic;
        out_async, out_sync : out std_logic -- or appropriate output type
        -- [...]
    );
end fsm;

architecture behavioral of fsm is
    type state_t is (
        s1, s2, -- [...]
        sN
    );
    signal ps : state_t := s1; -- present_state, default s1
    signal ns : state_t;       -- next_state
begin
    process (clk, nrst_async)
    begin
        if (nrst_async = '0') then
            ps <= s1; -- s1 default on reset
        elsif (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process;

    process (x, ps)
    begin
        case ps is
            when s1 =>
                out_sync <= 'U'; -- Synchronous/Moore. This case: (s1/U)
                if x = '1' then
                    out_async <= 'U'; -- Asynchronous/Mealy. This case: (s1/*)--x/U-->(sN/*)
                    ns        <= sN;
                else
                    out_async <= 'U'; -- Asynchronous/Mealy. This case: (s1/*)--\bar{x}/U-->(sN/*)
                    ns        <= sN;
                end if;
                -- [s2,...,sN]
        end case;
    end process;
end behavioral;
```

## Test 1

### Types

- structual modelling => describe connections between entities using `port map`
- dataflow modelling => concurrent execution of statements

```vhdl
A<=B;
C<=A;
...
```

- behavioral modelling => sequential execution

###

- Signals - signals are only mutated when the process finishes.
- Variables - variables are mutated at each statement in the process.

### Evaluation of process manually

- Double-check at end of first execution the sensitivity list to see if anything changes again

### Delay

Look at Expr evaluation value to decide if change should be rejected (not inputs)

- Transport `O <= TRANSPORT Expr AFTER 10 ns;`
- Inertial `O <= REJECT 10 ns INERTIAL Expr AFTER 10 ns;`
- Inertial `O <= Expr AFTER 10 ns;` (Inertial delay: `10 ns`, same as transport component)
- Delta time `O <= Expr` (Implicit - delta time is applied to concurrent statements when a statement is dependent on the output of a previous one. Expressions which can be executed concurrently have the same delta time)

Make table like this for delta time (required for followthrough marks):

NOTE: In 2024's papers, this table template was already included in the question sheet so you don't need to memorise the columns.

| Time  | Event | Processes triggered | Transactions enqueued | Causes event? |
| ----- | ----- | ------------------- | --------------------- | ------------- |
| 5 ns  | E->1  | U1                  | 10ns:E->0             | Y             |
| 10 ns | E->0  | U1                  | 15ns:E->1             | Y             |
| ...   | ...   | ...                 | ...                   | ...           |

### CHECKLIST

- Check for statements where inputs are assigned to or outputs are read from
  - Use signals instead
- Do not include data in sensitivity list for flip flops.
- Process: only use tokens with `sequential-statement` (`when` is not sequential)

## Test 2

### TEST 2 CAN HAVE ANY CONTENT FROM TEST 1

Do not forget how to do delta delay, timing diagrams, VHDL -> diagram or diagram -> VHDL.

### Test vectors ⚠

**Can be expressed using X for don't care** in tests/exams, do not need to enumerate every combination.

Example: "`11X0X`"

### identities

Re-remember these identities again for XOR method

| Name            | 1                                       | 2                                            |
| --------------- | --------------------------------------- | -------------------------------------------- |
| Absorption rule | $A(A+B)=A$                              | $A+AB=A$                                     |
| De Morgan's law | $\overline{AB}=\overline A+\overline B$ | $\overline{A+B}=\overline A\cdot\overline B$ |
| Idempotency     | $AA=A$                                  | $A+A=A$                                      |

### Path sensitization

Make sure to do the workshop question which has a branch after the fault! Understand how to identify the three paths (two single and one multiple).

## Timing

$$
\begin{align*}
    \delta_t &= \pm\delta'\qquad\text{Example: $\delta_t=\pm60$ ps}\\
    T_\text{min} &= T_\text{CQ,max} + T_\text{CL,max} + T_\text{setup,max} + |\delta_t|\\
    T_\text{hold} &\le T_\text{CQ,min} + T_\text{CL,min} - |\delta_t|
\end{align*}
$$

## Exam study

### Extra papers

Past exam papers are not provided, but from my 2024 experience the workshops and past tests are more than adequate for the exam questions.

If you need more questions, search "**ENGT2301**" on OneSearch. You will find a 2005 paper (note the 2005 deferred has the same questions). There's some obsolete questions involving JK flip-flops, but there's some useful ones on timing, state machines and path sensitization.

### **2024 EXAM OUTLINE IMPORTANT**

This was quoted from the final lecture.

- 5 questions x 20 marks
- **1** Testing 25 marks
  - No _XOR method_ (XOR can be used still for validation)
  - Path sensitization
- **2** Read VHDL (???)
- **3** VHDL -> Draw circuit
- **4** Circuit -> VHDL
- **5** Timing question (practical 5)
- 10 marks allocated to general questions
- NOTE: In the 2024 examination, calculators were allowed which was useful for the timing questions.

### Implementation technologies

- No practice questions, but may have worded questions

## Issues with saving file/modifying files not updating the simulation

The optimizer is once again causing issues.

My recommendation is to use `qrun` and do things in the terminal with `assert`s instead of trying to do it graphically using the verification diagrams. It also is much quicker.

For some reason, I can't get incremental compilation working and it just causes more issuse than the time it saves right now, since it results in changes not affecting the simulation, so for now I am cleanly rebuilding each simulation.

In GUI mode, manually start the simulation. When you need to update the simulation run this commandline

<!--
```bash
qrun $FILE_NAME -optimize -cleanlib -top $TOP_LEVEL_ENTITY; restart -force; run -all
``` -->

```bash
project compileoutofdate; restart -force; run -all
```

Here's also how to run the simulation in headless mode from a commandline (Do not run from Questa GUI, since it will make Questa quit)

```bash
qrun $FILE_NAME -optimize -simulate -cleanlib -top $TOP_LEVEL_ENTITY
```

## No objects appearing in modelsim/questa for testbenches

⚠ TODO: Fix previous issue in GUI as well (I am now using qrun instead of the GUI).

This is because the signals are being optimized out since they aren't really used for anything useful.

The intel questa/modelsim version shipped with the unit is 18.1, but this allowed vopt to be disabled. This is no longer the case on the latest versions of intel questa (You will get a compile error if you disable vopt flow).

Go to `Simulate > Start Simulation...`, ensure optimization is enabled then click on `Optimization Options...`

![Start simulation GUI](/assets/img/2024-08-19-ELEC4406ELEC2311-not/start_simulation.png)

Then select `Apply full visibility to all modules(full debug mode)` and press `OK`.

![Enable debug mode](/assets/img/2024-08-19-ELEC4406ELEC2311-not/debug_mode.png)

Alternatively, add `+acc` to `voptargs` if you are using the TCL command line:

```tcl
# Start simulation and add all waves
vsim $TESTBENCH_ID -voptargs=+acc; add wave *
```

## Dark mode in Intel/Altera Quartus

Run this script I made on Windows. [🔗Link](https://github.com/peter-tanner/Intel-Quartus-Dark-Mode-Windows)
