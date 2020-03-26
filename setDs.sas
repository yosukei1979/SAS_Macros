/*******************************************************************************
    FILE NAME    : setDs.sas
    TITLE   : Set specified datasets without cut off
    PRODUCT : SAS R9.4
    AUTHOR  : Y.Inaba
    DATE    : 2019/11/28
    Desc     : 
*******************************************************************************/
%Macro setDs(DS=, Output=);
%let cnt=%eval(%sysfunc(count(&DS.,$))+1);
%put &cnt;
data _macro0001;
	length mvar temp1 $256;
	mvar=symget("DS");
	do i=1 to &cnt.;
		temp1=upcase(scan(mvar,i,"$"));
	output;
	end;
run;

proc sql noprint;
	select 
		temp1,
		temp1,
		"_macro" || temp1
	into 
		:_mtemp1 separated by """,""",
		:_mtemp2 separated by " ",
		:_mtemp3 separated by " "
	from  _macro0001;
quit;

proc contents data=work._all_ out=varl(where=(upcase(memname) in ("&_mtemp1."))) noprint;
run;

proc sql;
create table varl2 as select
memname,
name,
varnum,
max(length) as mlen
from varl
group by name
order by memname,varnum;
quit;

data _null_;
set varl2 end=eof;
by memname;

if first.memname then do;
call execute(cat("data _macro",strip(memname),"; set ",strip(memname),";run;"));
call execute("proc sql;");
call execute(cat("alter table _macro",strip(memname)," modify"));
call execute(cat(strip(name)," char(",strip(put(mlen,best. -L)),")"));
end;
call execute(cat(",",strip(name)," char(",strip(put(mlen,best. -L)),")"));
if last.memname then do;
call execute(";");
call execute("quit;");
end;

run;

data &Output.;
set &_mtemp3.;
run;

proc datasets nolist;
	delete _macro:;
quit;
%Mend setDs;
