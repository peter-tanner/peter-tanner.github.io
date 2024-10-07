---
title: ELEC4406/ELEC2311 notes and tips
author: peter
date: 2024-08-19 02:26:49 +0800
categories: [Blogging] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [getting started] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-08-19-ELEC4406ELEC2311-not/preview.png
---

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
vcom *.vhd; restart -force; run -all
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

## Dark mode in intel quartus

Run this script I made on windows. [🔗Link](https://github.com/peter-tanner/Intel-Quartus-Dark-Mode-Windows)

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

## Lab quick reference

Tip: when using pin planner, you can copy paste multiple selections if you are using vscode multi cursors and copying from the markdown version of this page. Useful for filling out seven segment displays.

| Key                           | Value          | Notes                                                                                  |
| ----------------------------- | -------------- | -------------------------------------------------------------------------------------- |
| Part number                   | 10M50DAF484C7G |                                                                                        |
| 50 MHz signal (MAX10_CLK1_50) | PIN_P11        |                                                                                        |
| KEY0                          | PIN_B8         | Default: HIGH (Pullup). ⚠ IMPORTANT: USE 2.5V Schmitt trigger I/O standard to debounce |
| KEY1                          | PIN_A7         | Default: HIGH (Pullup). ⚠ IMPORTANT: USE 2.5V Schmitt trigger I/O standard to debounce |
| SW0                           | PIN_C10        |                                                                                        |
| SW1                           | PIN_C11        |                                                                                        |
| SW2                           | PIN_D12        |                                                                                        |
| SW3                           | PIN_C12        |                                                                                        |
| SW4                           | PIN_A12        |                                                                                        |
| SW5                           | PIN_B12        |                                                                                        |
| SW6                           | PIN_A13        |                                                                                        |
| SW7                           | PIN_A14        |                                                                                        |
| SW8                           | PIN_B14        |                                                                                        |
| SW9                           | PIN_F15        |                                                                                        |
| LEDR0                         | PIN_A8         |                                                                                        |
| LEDR1                         | PIN_A9         |                                                                                        |
| LEDR2                         | PIN_A10        |                                                                                        |
| LEDR3                         | PIN_B10        |                                                                                        |
| LEDR4                         | PIN_D13        |                                                                                        |
| LEDR5                         | PIN_C13        |                                                                                        |
| LEDR6                         | PIN_E14        |                                                                                        |
| LEDR7                         | PIN_D14        |                                                                                        |
| LEDR8                         | PIN_A11        |                                                                                        |
| LEDR9                         | PIN_B11        |                                                                                        |
| HEX00                         | PIN_C14        |                                                                                        |
| HEX01                         | PIN_E15        |                                                                                        |
| HEX02                         | PIN_C15        |                                                                                        |
| HEX03                         | PIN_C16        |                                                                                        |
| HEX04                         | PIN_E16        |                                                                                        |
| HEX05                         | PIN_D17        |                                                                                        |
| HEX06                         | PIN_C17        |                                                                                        |
| HEX07                         | PIN_D15        | DECIMAL POINT                                                                          |
| HEX10                         | PIN_C18        |                                                                                        |
| HEX11                         | PIN_D18        |                                                                                        |
| HEX12                         | PIN_E18        |                                                                                        |
| HEX13                         | PIN_B16        |                                                                                        |
| HEX14                         | PIN_A17        |                                                                                        |
| HEX15                         | PIN_A18        |                                                                                        |
| HEX16                         | PIN_B17        |                                                                                        |
| HEX17                         | PIN_A16        | DECIMAL POINT                                                                          |
| HEX20                         | PIN_B20        |                                                                                        |
| HEX21                         | PIN_A20        |                                                                                        |
| HEX22                         | PIN_B19        |                                                                                        |
| HEX23                         | PIN_A21        |                                                                                        |
| HEX24                         | PIN_B21        |                                                                                        |
| HEX25                         | PIN_C22        |                                                                                        |
| HEX26                         | PIN_B22        |                                                                                        |
| HEX27                         | PIN_A19        | DECIMAL POINT                                                                          |
| HEX30                         | PIN_F21        |                                                                                        |
| HEX31                         | PIN_E22        |                                                                                        |
| HEX32                         | PIN_E21        |                                                                                        |
| HEX33                         | PIN_C19        |                                                                                        |
| HEX34                         | PIN_C20        |                                                                                        |
| HEX35                         | PIN_D19        |                                                                                        |
| HEX36                         | PIN_E17        |                                                                                        |
| HEX37                         | PIN_D22        | DECIMAL POINT                                                                          |
| HEX40                         | PIN_F18        |                                                                                        |
| HEX41                         | PIN_E20        |                                                                                        |
| HEX42                         | PIN_E19        |                                                                                        |
| HEX43                         | PIN_J18        |                                                                                        |
| HEX44                         | PIN_H19        |                                                                                        |
| HEX45                         | PIN_F19        |                                                                                        |
| HEX46                         | PIN_F20        |                                                                                        |
| HEX47                         | PIN_F17        | DECIMAL POINT                                                                          |
| HEX50                         | PIN_J20        |                                                                                        |
| HEX51                         | PIN_K20        |                                                                                        |
| HEX52                         | PIN_L18        |                                                                                        |
| HEX53                         | PIN_N18        |                                                                                        |
| HEX54                         | PIN_M20        |                                                                                        |
| HEX55                         | PIN_N19        |                                                                                        |
| HEX56                         | PIN_N20        |                                                                                        |
| HEX57                         | PIN_L19        | DECIMAL POINT                                                                          |

identity:

```vhdl
"000000001"
"000000010"
"000000100"
"000001000"
"000010000"
"000100000"
"001000000"
"010000000"
"100000000"
```

## identities

| Name            | 1                                       | 2                                            |
| --------------- | --------------------------------------- | -------------------------------------------- |
| Absorption rule | $A(A+B)=A$                              | $A+AB=A$                                     |
| De Morgan's law | $\overline{AB}=\overline A+\overline B$ | $\overline{A+B}=\overline A\cdot\overline B$ |
| Idempotency     | $AA=A$                                  | $A+A=A$                                      |

## fsm template

```vhdl
entity fsm is port (
  clk,nrst,x in : std_logic;
  ...
);
end fsm;

architecture behavioral of fsm is
  type state is {sdefault, s1, s2, ...};
  signal ps, ns : state; -- present_state, next_state
begin
  process (clk, nrst)
  begin
    if (nrst = '0') then
      ps <= sdefault;
    elsif (rising_edge(clk)) then
      ps <= ns;
    end if;
  end process;

  process (x,ps)
  begin
    case x is
      when s1 =>
    [...]
  end process;
end behavioral;
```

## lab-test tips

The lab test has a very high time pressure (kind of like comms if you have/are doing it).

- Use the DE-10 board project template to prevent wasting time entering pin definitions in the pin planner GUI.
- Bring in components for clock divider, 7 segment display, FSM template and all lab materials at the minimum.
- Focus on getting a working design before moving on to another design, they will only give one mark if your design has code, but you can't demonstrate it working (mock lab test). If your working design has a bug then they don't take too many marks away in my experience (mock lab test: I had a speed switch erroneously affect both speed and direction of a FSM - this only copped a 1 mark penalty in the mock lab test).
- Enable autocomplete. It's better than nothing, but it's definitely not intellisense.

![Enable autocomplete](/assets/img/2024-08-19-ELEC4406ELEC2311-not/autocomplete.png)

- **Check for your current year**. As of 2024, you may use your personal computer in the test and you don't need to use the lab computers (subject to same restrictions). You may not use anything other than Altera Quartus, Modelsim and Adobe Acrobat. You _cannot_ use vscode.
