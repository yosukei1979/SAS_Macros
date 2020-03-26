/*******************************************************************************
    FILE NAME    : char2num.sas
    TITLE   : Convert character type variable to numeric 
    PRODUCT : SAS R9.4
    AUTHOR  : Y.Inaba
    DATE    : 2019/9/13
    Desc     : 
*******************************************************************************/
%Macro char2num(Input=, Output=, Var=);
%let cnt=%eval(%sysfunc(count(&Var.,$))+1);
%put &cnt;
data _macro0001;
	length mvar temp1 $256;
	mvar=symget("Var");
	do i=1 to &cnt.;
		temp1=scan(mvar,i,"$");
		temp2=cats(temp1,"=_temporary_",temp1);
		temp3=cats(temp1,"=input(_temporary_",temp1,",best.);");
	output;
	end;
run;

proc sql noprint;
	select 
		temp1,
		temp2,
		temp3 
	into 
		:_mtemp1 separated by " "  ,
		:_mtemp2 separated by " ",
		:_mtemp3 separated by ";"
	from  _macro0001;
quit;

data  &Output.(drop=_temporary_:);
set &Input.(rename=(&_mtemp2.));
length &_mtemp1. 8.;
&_mtemp3.;
run;

proc datasets nolist;
	delete _macro:;
quit;
%Mend char2num;
