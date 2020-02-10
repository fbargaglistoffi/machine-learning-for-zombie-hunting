* EMU eurostat

clear all

import excel "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\EMU convergence criterion bond\emu.xlsx", sheet("Foglio1") firstrow



label variable GEOTIME "GEOTIME"

foreach var of varlist * {
    local x : variable label `var'
    rename `var' _`x', force
}

forvalues i = 2005/2016{
	egen emu_`i' = rowtotal(_`i'M01 - _`i'M12)
	replace emu_`i' = (emu_`i')/12
	replace emu_`i' = round(emu_`i', 0.01)
}

clear all

import excel "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\EMU convergence criterion bond\emu_2004_2007.xlsx", sheet("Foglio1") firstrow

label variable GEOTIME "GEOTIME"

foreach var of varlist * {
    local x : variable label `var'
    rename `var' _`x', force
}

forvalues i = 2004/2007{
	egen emu_`i' = rowtotal(_`i'M01 - _`i'M12)
	replace emu_`i' = (emu_`i')/12
	replace emu_`i' = round(emu_`i', 0.01)
}
