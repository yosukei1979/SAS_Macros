/*******************************************************************************
    FILE NAME    : num2char.sas
    TITLE   : Convert num type variable to character 
    PRODUCT : SAS R9.4
    AUTHOR  : Y.Inaba
    DATE    : 2019/8/30
    Desc     : &Var= can specify some variables by delimiting with $
*******************************************************************************/
%Macro num2char(Input=, Output=, Var=,clen=5000);
%let cnt=%eval(%sysfunc(count(&Var.,$))+1);
%put &cnt;
data _macro0001;
	length mvar temp1 $256;
	mvar=symget("Var");
	do i=1 to &cnt.;
		temp1=scan(mvar,i,"$");
		temp2=cats(temp1,"=_temporary_",temp1);
		temp3=cats(temp1,"=put(_temporary_",temp1,",best. -L);");
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
length &_mtemp1. $&clen.;
&_mtemp3.;
run;

proc datasets nolist;
	delete _macro:;
quit;
%Mend num2char;
