
*************************;
* Clear the LOG window and reset LOG line numbering;
*************************;
dm 'log' clear;  
resetline;
*************************;

libname hw4 "C:\Users\bprom19\Desktop\ECON 673 HW Data\HW_4\HW4Data";

data Haul_03;
length ticket $9;
set hw4.Haul_2012_03 (rename= (Gross_Hauled_Barrels=Hauled));
format ticket $9.;
Driver_ID = upcase(Driver_ID);
run;

data Haul_04;
length ticket $9;
set hw4.Haul_2012_04 (rename=(Driver=Driver_ID ticket=ticket date=Haul_date Gross_Hauled_BBLS=Hauled));
format ticket $9.;
Driver_ID = upcase(Driver_ID);
run;

data Haul_05;
length ticket $9;
set hw4.Haul_2012_05 (rename=(Driver_No=Driver_ID Gross_Hauled=Hauled));
format ticket $9.;
Driver_ID = upcase(Driver_ID);
Hauled = Hauled/42;
run;

data Haul_06;
length ticket $9;
set hw4.Haul_2012_06 (rename=(Driver=Driver_ID date=Haul_date Gross_Hauled_Barrels=Hauled));
format ticket $9.;
Driver_ID = upcase(Driver_ID);
run;

data HW4;
set Haul_03  Haul_04 Haul_05 Haul_06;
if hauled = 0 then hauled=.;
run;

*ods excel file="C:\Users\bprom19\OneDrive\TAMU\Fall 2022\Econ 673\HW\HW_4\HW4_1_3.xlsx";
proc means data=hw4 NMiss Mean;
title "Number Hauls "; 
var hauled;
class driver_id;
run;
*ods excel close;

*ods excel file="C:\Users\bprom19\OneDrive\TAMU\Fall 2022\Econ 673\HW\HW_4\HW4_Last_Q.xlsx";
proc means data=hw4 mean ;
title "Hauls Over the Company Limit of 190";
class driver_id;
where hauled >190;
var hauled;
run;
*ods excel close;
/*
PROC IMPORT
DATAFILE= "C:\Users\bprom19\OneDrive\TAMU\Fall 2022\Econ 673\HW\HW_4\HW4_1_3.xlsx"
DBMS= xlsx
out = work.Number_1 replace;
sheet="Means 1 - Summary statistics";
RUN;
PROC IMPORT
DATAFILE= "C:\Users\bprom19\OneDrive\TAMU\Fall 2022\Econ 673\HW\HW_4\HW4_Last_Q.xlsx"
DBMS= xlsx
out = work.Number_4 replace;
sheet="Means 1 - Summary statistics";
RUN;

proc sort data=number_1 out=Sort_1;
by driver_id;
run;

proc sort data=number_4 out=sort_2;
by driver_id;
run;

data Final_Result;
merge sort_1 sort_2;
by driver_id;
run;








