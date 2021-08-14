//#################################### dx7.lib #########################################
// Yamaha DX7 emulation library. Its official prefix is `dx`.
//########################################################################################
// Yamaha DX7 emulation library. The various functions available in this library
// are used by the libraries generated from `.syx` DX7 preset files. This
// toolkit was greatly inspired by the CSOUND DX7 emulation package:
// <http://www.parnasse.com/dx72csnd.shtml>.
//
// This library and its related tools are under development. Use it at your
// own risk!
//##############################################################################

// FAUST library file, GRAME section

// Except where noted otherwise, Copyright (C) 2003-2017 by GRAME,
// Centre National de Creation Musicale.
// ----------------------------------------------------------------------
// GRAME LICENSE

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation; either version 2.1 of the
// License, or (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.

// You should have received a copy of the GNU Lesser General Public
// License along with the GNU C Library; if not, write to the Free
// Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
// 02111-1307 USA.

// EXCEPTION TO THE LGPL LICENSE : As a special exception, you may create a
// larger FAUST program which directly or indirectly imports this library
// file and still distribute the compiled code generated by the FAUST
// compiler, or a modified version of this compiled code, under your own
// copyright and license. This EXCEPTION TO THE LGPL LICENSE explicitly
// grants you the right to freely choose the license for the resulting
// compiled code. In particular the resulting compiled code has no obligation
// to be LGPL or GPL. For example you are free to choose a commercial or
// closed source license or any other license if you decide so.
declare name "dx7";
declare options "[nvoices:8]"; // FaustProcessor has a property which will override this.

// ALGORITHM = 0;
dx7_ui =
dx.dx7_algo(ALGORITHM,egR1,egR2,egR3,egR4,egL1,egL2,egL3,egL4,outLevel,keyVelSens,ampModSens,opMode,opFreq,opDetune,opRateScale,feedback,lfoDelay,lfoDepth,lfoSpeed,freq,gain,gate) :> _
with{
	feedback = hslider("global/feedback",0,0,99,1) : dx.dx7_fdbkscalef/(2*ma.PI);
	lfoDelay = hslider("global/lfoDelay",0,0,99,1);
	lfoDepth = hslider("global/lfoDepth",0,0,99,1);
	lfoSpeed = hslider("global/lfoSpeed",0,0,99,1);
	freq = hslider("freq",400,50,1000,0.01);
	gain = hslider("gain",0.8,0,1,0.01);
	gate = button("gate");
	egR1UI = par(i,6,hslider("op%i/egR1",90,0,99,1));
	egR1(n) = ba.take(n+1,egR1UI);
	egR2UI = par(i,6,hslider("op%i/egR2",90,0,99,1));
	egR2(n) = ba.take(n+1,egR2UI);
	egR3UI = par(i,6,hslider("op%i/egR3",90,0,99,1));
	egR3(n) = ba.take(n+1,egR3UI);
	egR4UI = par(i,6,hslider("op%i/egR4",90,0,99,1));
	egR4(n) = ba.take(n+1,egR4UI);
	egL1UI = par(i,6,hslider("op%i/egL1",0,0,99,1));
	egL1(n) = ba.take(n+1,egL1UI);
	egL2UI = par(i,6,hslider("op%i/egL2",90,0,99,1));
	egL2(n) = ba.take(n+1,egL2UI);
	egL3UI = par(i,6,hslider("op%i/egL3",90,0,99,1));
	egL3(n) = ba.take(n+1,egL3UI);
	egL4UI = par(i,6,hslider("op%i/egL4",0,0,99,1));
	egL4(n) = ba.take(n+1,egL4UI);
	outLevelUI = par(i,6,hslider("op%i/level",95,0,99,1));
	outLevel(n) = ba.take(n+1,outLevelUI);
	keyVelSensUI = par(i,6,nentry("op%i/keyVelSens",1,0,8,1));
	keyVelSens(n) = ba.take(n+1,keyVelSensUI);
	ampModSensUI = par(i,6,hslider("op%i/ampModSens",0,0,99,1));
	ampModSens(n) = ba.take(n+1,ampModSensUI);
	opModeUI = par(i,6,nentry("op%i/opMode",0,0,1,1));
	opMode(n) = ba.take(n+1,opModeUI);
	opFreqUI = par(i,6,hslider("op%i/opFreq",1.0,0.0,2.0,0.01));
	opFreq(n) = ba.take(n+1,opFreqUI);
	opDetuneUI = par(i,6,hslider("op%i/opDetune",1,-10,10,1));
	opDetune(n) = ba.take(n+1,opDetuneUI);
	opRateScaleUI = par(i,6,hslider("op%i/opRateScale",0,0,10,1));
	opRateScale(n) = ba.take(n+1,opRateScaleUI);
};

myFilter = fi.lowpass(10, hslider("cutoff", 20000., 30., 20000., 0.1));

process = dx7_ui <: _, _;
effect = myFilter, myFilter;