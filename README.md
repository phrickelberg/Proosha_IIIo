Proosha IIIo
=========================

This RepRap is available under GPL license.

This is basically a Prusa i3 Einstein Rework with minor changes such as:

* wood-style frame with fins upgraded to fit the Einstein Rework Y-CORNERS
* stronger X-END-IDLER
* stronger X-END-MOTOR
* preconfigured Marlin Firmware

Building instructions
-------------------------
Instead of the original threaded rod configuration, you need

* 2x Threaded rod M5x300 mm
* 2x Threaded rod M10x210 mm
* 2x Threaded rod M10x365 mm
* 2x Threaded rod M10x380 mm

and a few more M10 nuts and washers plus two M8 x 20 mm screws.

You also need to tap the printed X-END-IDLER-BETTER.stl twice with a M8 x 1,25 thread. Thats where the two M8 x 20 mm screws go.

Besides that, just follow the instructions from [the original project page](http://reprap.org/wiki/Prusa_i3_Rework_Introduction/de)

If you want to use the preconfigured Marlin Firmware, please make sure you got your hardware configured as followed:
* explanation:				{X-AXIS, Y-AXIS, Z-AXIS, EXTRUDER}
* microstepping:			{1/8, 1/8, 1/4, 1/4}
* motors step angle:	{1.8, 1.8, 1.8, 1.8}
* transmission:				{20 teeth GT2, 20 teeth GT2, M5 thread (0.8 mm/rev), hardened steel hobbed bolt + wade gear}

Roadmap
-------------------------

- [x] modifying the x-end idler to more solid, right now the ball-bearing mount it's a predetermined breaking point
- [x] modifying the wood frame fins to fit the i3 EINSTEIN Rework y-corners and 10mm threaded rods
- [ ] modifying the y-carrier for 3-point leveling AND for triggering the lower y-endstop even if the bed is mounted a few mm higher (i.e. due to leveling screws)

Sources
-------------------------

* Prusa i3 EINSTEIN Rework Introduction [github.com](http://reprap.org/wiki/Prusa_i3_Rework_Introduction)
* Extruder-Classic parts by ch1t0 [Thingiverse](http://www.thingiverse.com/thing:76660)
* Extruder-E3D parts by Mak-a-face [Thingiverse](http://www.thingiverse.com/thing:76660)
* Extruder parts by ch1t0 [Thingiverse](http://www.thingiverse.com/thing:76660)
* Marlin Firmware [GitHub](https://github.com/ErikZalm/Marlin)

