/*******************************************************************************
    FILE NAME    : Surv_prob.sas
    TITLE   : SAS Macro program for calculating Survival probability from ODS table SurvivalPlot
    PRODUCT : SAS R9.4
    AUTHOR  : Yosuke Inaba
    DATE    : 2020/3/25
    Discription
		Input: Specify input dataset name(Output from ODS Table  SurvivalPlot)
		Output: Specify output dataset name
		Time: Time-point to obtain survival probability
*******************************************************************************/

%Macro Surv_prob(Input, Output, Time);

data _macro0001;
set &Input.;
where ^missing(survival);
lag1time=lag1(time);
lag1SDF_UCL=lag1(SDF_UCL);
lag1SDF_LCL=lag1(SDF_LCL);
lag1Survival=lag1(Survival);
run;

data &Output.(rename=(lag1SDF_UCL=SDF_UCL lag1SDF_LCL=SDF_LCL lag1Survival=Survival));
set _macro0001(keep=lag1time time lag1SDF_UCL lag1SDF_LCL lag1Survival Stratum);
where lag1time<=&Time. <=time;
surv_time=&Time.;
drop time lag1time;
run;

proc datasets lib=work nolist;
    delete _macro:;
quit;

%Mend Surv_prob;
